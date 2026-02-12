/*
 * Author: Eludage
 * Remote execution function to pause the currently playing song for all clients.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_remotePauseSong;
 */
disableSerialization;

// Get current track
private _currentTrack = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];
private _isPlaying = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingActive", false];

if (_currentTrack == "" || !_isPlaying) exitWith {
	false
};

// remote Execute code block to pause music on each client
private _remoteCode = compile "private _wasPreviewPlaying = uiNamespace getVariable ['ZeusJukebox_previewPlaying', false]; private _previewTrack = uiNamespace getVariable ['ZeusJukebox_previewTrack', '']; if (_wasPreviewPlaying && _previewTrack != '') then {} else { playMusic ''; };";
_remoteCode remoteExec ["call", 0, false];

// Store paused position
private _startTime = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingStartTime", 0];
private _pausedAt = serverTime - _startTime;
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingPausedAt", _pausedAt, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingActive", false, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiCurrentlyPlaying;

true