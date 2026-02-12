/*
 * Author: Eludage
 * Handles preview music progress tracking and stops when finished
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_handlePreviewMusicProgress;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Get preview track info
private _previewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
if (_previewTrack == "") exitWith { false };

// Get track duration from uiNamespace
private _duration = uiNamespace getVariable ["ZeusJukebox_previewDuration", 0];
if (_duration <= 0) exitWith { false }; // No valid duration

// Calculate elapsed time
private _startTime = uiNamespace getVariable ["ZeusJukebox_previewStartTime", time];
private _elapsed = time - _startTime;

// Check if track finished
if (_elapsed >= _duration) then {
    // Track finished, stop playback
    playMusic "";
    uiNamespace setVariable ["ZeusJukebox_previewPlaying", false];
    uiNamespace setVariable ["ZeusJukebox_previewPausedAt", 0];
};

// Update UI
[] call ZeusJukebox_fnc_updateUiPreviewArea;

true
