/*
 * Author: Eludage
 * Handles progress bar click events for the preview track to seek playback position.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPreviewProgressBarClick;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Get the preview track
private _previewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
if (_previewTrack == "") exitWith { false };

// Get track duration from uiNamespace
private _duration = uiNamespace getVariable ["ZeusJukebox_previewDuration", 0];
if (_duration <= 0) exitWith { false }; // No valid duration

// Get progress bar control to determine click position
private _progressBg = _display displayCtrl 15302;
if (isNull _progressBg) exitWith { false };

private _bgPos = ctrlPosition _progressBg;
private _bgX = _bgPos select 0;
private _bgW = _bgPos select 2;

// Get mouse position (in UI coordinates)
private _mousePos = getMousePosition;
private _mouseX = _mousePos select 0;

// Calculate relative position within the progress bar (0-1)
private _relativePos = (_mouseX - _bgX) / _bgW;
_relativePos = 0 max _relativePos min 1;

// Calculate the new time position
private _newTime = _relativePos * _duration;

// Get current play state
private _isPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];

// Update the paused position
uiNamespace setVariable ["ZeusJukebox_previewPausedAt", _newTime];

// If currently playing, restart playback from new position
if (_isPlaying) then {
    // Play from new position
    playMusic [_previewTrack, _newTime];

    // Update start time to reflect new position
    uiNamespace setVariable ["ZeusJukebox_previewStartTime", time - _newTime];
};

// Update UI
[] call ZeusJukebox_fnc_updateUiPreviewArea;

true
