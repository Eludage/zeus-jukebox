/*
 * Author: Eludage
 * Remote execution function to play a song for all clients.
 *
 * Arguments:
 * 0: String - Class name of the track to play
 * 1: Number - Start position in seconds (default: 0)
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * ["LeadTrack01_F_EPC", 0] call ZeusJukebox_fnc_remotePlaySong;
 */
disableSerialization;

params [
	["_trackClass", "", [""]],
	["_startPosition", 0, [0]]
];

// Validate track class name
if (_trackClass == "") exitWith {
	false
};

// Get track duration from config
private _trackInfo = [_trackClass] call ZeusJukebox_fnc_getTrackConfig;
if (count _trackInfo == 0) exitWith {
	false
};

_trackInfo params ["_config", "_displayName", "_duration", "_soundFile"];

// Set missionNamespace variables
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingTrack", _trackClass, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingStartTime", serverTime - _startPosition, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingDuration", _duration, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingActive", true, true];

// Escape single quotes in track class to prevent code injection
private _trackClassEscaped = _trackClass;
if (_trackClass find "'" >= 0) then {
	private _chars = toArray _trackClass;
	private _result = "";
	{
		if (_x == 39) then {
			_result = _result + "''";
		} else {
			_result = _result + toString [_x];
		};
	} forEach _chars;
	_trackClassEscaped = _result;
};

// remote Execute code block to play music on each client
private _remoteCode = compile format ["private _wasPreviewPlaying = uiNamespace getVariable ['ZeusJukebox_previewPlaying', false]; private _previewTrack = uiNamespace getVariable ['ZeusJukebox_previewTrack', '']; if (_wasPreviewPlaying && _previewTrack != '') then {} else { playMusic ['%1', %2]; };", _trackClassEscaped, _startPosition];
_remoteCode remoteExec ["call", 0, false];

// Terminate any existing progress loop before spawning new one
private _existingHandle = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingUpdateHandle", scriptNull];
if (!isNull _existingHandle) then {
    terminate _existingHandle;
};

// Start handling the playing music progress
private _handle = [] spawn {
    disableSerialization;

    while {missionNamespace getVariable ["ZeusJukebox_currentlyPlayingActive", false]} do {
        [] call ZeusJukebox_fnc_handlePlayingMusicProgress;
        sleep 0.2;
    };
    
    // Clear handle when loop ends
    missionNamespace setVariable ["ZeusJukebox_currentlyPlayingUpdateHandle", scriptNull];
};
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingUpdateHandle", _handle];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiCurrentlyPlaying;

true