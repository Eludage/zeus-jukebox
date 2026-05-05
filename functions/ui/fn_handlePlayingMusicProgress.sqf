/*
 * Author: Eludage
 * Handle the current music playing state
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ZeusJukebox_fnc_handlePlayingMusicProgress;
 */

 disableSerialization;

 // Read state from missionNamespace
 private _currentTrack = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];
 private _isActive = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingActive", false];

 if (_currentTrack == "" || !_isActive) exitWith { false };

 // Duration is stored by remotePlaySong — no config lookup needed on every tick
 private _duration = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingDuration", 0];
 if (_duration <= 0) exitWith { false };

// Calculate elapsed time
private _startTime = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingStartTime", serverTime];
private _elapsed = serverTime - _startTime;

// Check if track finished
if (_elapsed >= _duration) then {
    private _looping = missionNamespace getVariable ["ZeusJukebox_looping", false];
    private _autoplay = missionNamespace getVariable ["ZeusJukebox_autoplay", false];
    if (_looping) then {
        // Replay the same track from the beginning using the stored sound file
        private _soundFile = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingSoundFile", ""];
        [_currentTrack, 0, _soundFile] call ZeusJukebox_fnc_remotePlaySong;
    } else {
        // Track finished - stop and remove it
        missionNamespace setVariable ["ZeusJukebox_currentlyPlayingActive", false, true];
        [] call ZeusJukebox_fnc_remoteRemoveSong;

        // After removal, check if autoplay should start next track
        if (_autoplay) then {
            [] call ZeusJukebox_fnc_checkAutoplay;
        };
    };
} else {
    // Track still playing - update UI if dialog is open
    [] call ZeusJukebox_fnc_remoteTriggerUpdateUiCurrentlyPlaying;
};
