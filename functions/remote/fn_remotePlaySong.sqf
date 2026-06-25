/*
 * Author: Eludage
 * Remote execution function to play a song for all clients.
 *
 * Arguments:
 * 0: String - Class name of the track to play
 * 1: Number - Start position in seconds (default: 0)
 * 2: String - Sound file path to play (default: ""). When provided, playMusic uses this path
 *             directly instead of resolving the class name through the engine config, allowing
 *             correct playback when a mod and mission declare the same class name.
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * ["LeadTrack01_F_EPC", 0, "music\track.ogg"] call ZeusJukebox_fnc_remotePlaySong;
 */
disableSerialization;

params [
	["_trackClass", "", [""]],
	["_startPosition", 0, [0]],
	["_soundFile", "", [""]]
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

_trackInfo params ["_config", "_displayName", "_duration", "_soundFileFromConfig"];

// Set missionNamespace variables
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingTrack", _trackClass, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingStartTime", serverTime - _startPosition, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingDuration", _duration, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingActive", true, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingSoundFile", _soundFile, true];

// Always use the class name for playMusic — raw file paths from CfgMusic's sound[]
// array reference packed PBO files that cannot be opened directly by playMusic.
// The _soundFile is kept for display/metadata purposes only.
private _remoteCode = compile format ["private _wasPreviewPlaying = uiNamespace getVariable ['ZeusJukebox_previewPlaying', false]; private _previewTrack = uiNamespace getVariable ['ZeusJukebox_previewTrack', '']; if (_wasPreviewPlaying && _previewTrack != '') then {} else { playMusic ['%1', %2]; };", _trackClass, _startPosition];
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
