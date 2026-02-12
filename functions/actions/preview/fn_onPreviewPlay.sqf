/*
 * Author: Eludage
 * Handles the play button click for the preview track.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPreviewPlay;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Get current preview state
private _currentPreviewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
private _isPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];

if (_isPlaying) exitWith { false }; // Already playing, do nothing

// Start/Resume the preview
private _pausedAt = uiNamespace getVariable ["ZeusJukebox_previewPausedAt", 0];

// Play the music locally (only for this client)
playMusic [_currentPreviewTrack, _pausedAt];

// Auto-mute Currently Playing for Zeus when previewing
// (so Zeus doesn't hear both preview and currently playing at once)
private _isCurrentlyPlaying = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingActive", false];
if (_isCurrentlyPlaying) then {
    private _wasListening = uiNamespace getVariable ["ZeusJukebox_isListeningLocally", true];
    if (_wasListening) then {
        uiNamespace setVariable ["ZeusJukebox_isListeningLocally", false];
        
        // Trigger UI update to show listen button state
        [] call ZeusJukebox_fnc_updateUiCurrentlyPlaying;
    };
};

// Store start time (adjusted for paused position)
uiNamespace setVariable ["ZeusJukebox_previewStartTime", serverTime - _pausedAt];
uiNamespace setVariable ["ZeusJukebox_previewPlaying", true];

// Update UI
[] call ZeusJukebox_fnc_updateUiPreviewArea;

// Start progress update loop
[] spawn {
    disableSerialization;

    while {uiNamespace getVariable ["ZeusJukebox_previewPlaying", false]} do {
        [] call ZeusJukebox_fnc_handlePreviewMusicProgress;
        sleep 0.1;
    };
};

true
