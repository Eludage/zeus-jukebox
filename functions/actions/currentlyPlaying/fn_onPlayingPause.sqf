/*
 * Author: Eludage
 * Handles the pause button click for the currently playing track.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlayingPause;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Get current track
private _currentTrack = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];

if (_currentTrack == "") exitWith {
	false
};

// Get current playing state
private _isPlaying = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingActive", false];
if (!_isPlaying) exitWith {
	false
};

// Pause the track using remote execution
[] call ZeusJukebox_fnc_remotePauseSong;

true