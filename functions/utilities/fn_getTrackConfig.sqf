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

// Get track config - check both configFile (addons) and missionConfigFile (mission)
private _config = configFile >> "CfgMusic" >> _className;
if (!isClass _config) then {
    _config = missionConfigFile >> "CfgMusic" >> _className;
};

if (!isClass _config) exitWith { [] };

// Get track info
private _displayName = getText (_config >> "name");
private _duration = getNumber (_config >> "duration");
private _soundArray = getArray (_config >> "sound");
private _soundFile = if (count _soundArray > 0) then { _soundArray select 0 } else { "-" };

if (_displayName == "") then {
    _displayName = _className;
};

// Fallback duration if not specified (180 seconds = 3 minutes)
if (_duration == 0) then {
    _duration = 180;
};

[_config, _displayName, _duration, _soundFile]
