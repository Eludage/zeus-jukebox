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
 
 // Get track duration using utility
 private _duration = 0;
 private _trackInfo = [_currentTrack] call ZeusJukebox_fnc_getTrackConfig;
 if (!(_trackInfo isEqualTo [])) then {
     _trackInfo params ["_cfg", "_disp", "_trackDuration", "_file"];
     _duration = _trackDuration;
 };
 if (_duration <= 0) exitWith { false };

// Calculate elapsed time
private _startTime = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingStartTime", serverTime];
private _elapsed = serverTime - _startTime;

// Check if track finished
if (_elapsed >= _duration) then {
    // If looping is enabled, restart playback immediately
    private _looping = missionNamespace getVariable ["ZeusJukebox_looping", false];
    private _autoplay = missionNamespace getVariable ["ZeusJukebox_autoplay", false];
    if (_looping) then {
        // Replay the same track from the beginning
        [_currentTrack, 0] call ZeusJukebox_fnc_remotePlaySong;
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