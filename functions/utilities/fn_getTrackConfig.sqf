/*
 * Function: ZeusJukebox_fnc_getTrackConfig
 * Description: Gets track configuration from CfgMusic (checks both addon and mission config)
 *
 * Arguments:
 * 0: Class name of the track <STRING>
 *
 * Return Value:
 * Array: [config, displayName, duration, soundFile] or [] if not found
 *
 * Example:
 * private _info = ["Track_01"] call ZeusJukebox_fnc_getTrackConfig;
 */

params [["_className", "", [""]]];

if (_className == "") exitWith { [] };

// Check mission config first — mission CfgMusic overrides addon CfgMusic for the
// same class name, matching how playMusic resolves the class at runtime.
private _isMissionMusic = false;
private _config = missionConfigFile >> "CfgMusic" >> _className;
if (isClass _config) then {
    _isMissionMusic = true;
} else {
    _config = configFile >> "CfgMusic" >> _className;
};

if (!isClass _config) exitWith { [] };

// Get track info
private _displayName = getText (_config >> "name");
private _duration = getNumber (_config >> "duration");
// Mission-authored tracks use a constant soundFile placeholder instead of the
// real (mission-relative) sound[] path, since the same className can be reused
// across mission templates with the audio file in a different folder each time —
// a literal path here would silently break favorites (which persist across
// missions) whenever a Zeus moves the file. soundFile is never passed to
// playMusic (see fn_remotePlaySong.sqf), so this can't affect playback.
private _soundFile = if (_isMissionMusic) then {
    "mission_music"
} else {
    private _soundArray = getArray (_config >> "sound");
    if (count _soundArray > 0) then { _soundArray select 0 } else { "-" };
};

if (_displayName == "") then {
    _displayName = _className;
};

// Fallback duration if not specified (180 seconds = 3 minutes)
if (_duration == 0) then {
    _duration = 180;
};

[_config, _displayName, _duration, _soundFile]
