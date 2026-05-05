/*
 * Author: Eludage
 * Updates the Track Info display section with information about a specific track.
 *
 * Arguments:
 * 0: Track class name <STRING>
 * 1: Sound file path <STRING> (optional) - when provided, shown directly instead of
 *    looking it up from config, ensuring the correct source file is displayed.
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * ["LeadTrack01_F_Bootcamp", "music\track.ogg"] call ZeusJukebox_fnc_updateUiTrackInfo;
 */
disableSerialization;

params [["_className", "", [""]], ["_knownSoundFile", "", [""]]];

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Get controls
private _trackNameCtrl = _display displayCtrl 15202;
private _trackClassCtrl = _display displayCtrl 15204;
private _trackFileCtrl = _display displayCtrl 15206;
private _trackDurationCtrl = _display displayCtrl 15208;

// If no class name provided, clear the fields
if (_className == "") exitWith {
	if (!isNull _trackNameCtrl) then { _trackNameCtrl ctrlSetText "-"; _trackNameCtrl ctrlCommit 0; };
	if (!isNull _trackClassCtrl) then { _trackClassCtrl ctrlSetText "-"; _trackClassCtrl ctrlCommit 0; };
	if (!isNull _trackFileCtrl) then { _trackFileCtrl ctrlSetText "-"; _trackFileCtrl ctrlCommit 0; };
	if (!isNull _trackDurationCtrl) then { _trackDurationCtrl ctrlSetText "-"; _trackDurationCtrl ctrlCommit 0; };
	true
};

// Get track info from config (for display name, duration, and soundFile fallback)
private _trackInfo = [_className] call ZeusJukebox_fnc_getTrackConfig;
if (_trackInfo isEqualTo []) exitWith {
	// Track not found - show error values
	if (!isNull _trackNameCtrl) then { _trackNameCtrl ctrlSetText "Error"; _trackNameCtrl ctrlCommit 0; };
	if (!isNull _trackClassCtrl) then { _trackClassCtrl ctrlSetText _className; _trackClassCtrl ctrlCommit 0; };
	if (!isNull _trackFileCtrl) then { _trackFileCtrl ctrlSetText "Not found"; _trackFileCtrl ctrlCommit 0; };
	if (!isNull _trackDurationCtrl) then { _trackDurationCtrl ctrlSetText "-"; _trackDurationCtrl ctrlCommit 0; };
	false
};

_trackInfo params ["_config", "_displayName", "_duration", "_soundFileFromConfig"];

// Use the caller-supplied sound file when available (correct source-specific path)
private _soundFile = if (_knownSoundFile != "") then { _knownSoundFile } else { _soundFileFromConfig };

// Update controls
if (!isNull _trackNameCtrl) then { _trackNameCtrl ctrlSetText _displayName; _trackNameCtrl ctrlCommit 0; };
if (!isNull _trackClassCtrl) then { _trackClassCtrl ctrlSetText _className; _trackClassCtrl ctrlCommit 0; };
if (!isNull _trackFileCtrl) then { _trackFileCtrl ctrlSetText _soundFile; _trackFileCtrl ctrlCommit 0; };
if (!isNull _trackDurationCtrl) then {
	private _durationStr = [_duration] call ZeusJukebox_fnc_formatDuration;
	_trackDurationCtrl ctrlSetText _durationStr;
	_trackDurationCtrl ctrlCommit 0;
};

true
