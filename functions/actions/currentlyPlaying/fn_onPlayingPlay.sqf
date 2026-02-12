/*
 * Author: Eludage
 * Handles the play button click for the currently playing track.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlayingPlay;
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
if (_isPlaying) exitWith {
    false
};

// Get paused position (0 if not paused)
private _pausedAt = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingPausedAt", 0];

// Play the track using remote execution (plays for all clients)
[_currentTrack, _pausedAt] call ZeusJukebox_fnc_remotePlaySong;

true