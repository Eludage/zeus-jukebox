/*
 * Author: Eludage
 * Handles the pause button click for the preview track.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPreviewPause;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Get current preview state
private _currentPreviewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
private _isPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];

if (!_isPlaying) exitWith { false }; // If not playing, nothing to pause

// Stop the music
playMusic "";

// Store the current position when pausing
private _startTime = uiNamespace getVariable ["ZeusJukebox_previewStartTime", 0];
private _elapsed = serverTime - _startTime;
uiNamespace setVariable ["ZeusJukebox_previewPausedAt", _elapsed];

// Update state
uiNamespace setVariable ["ZeusJukebox_previewPlaying", false];

// Update UI
[] call ZeusJukebox_fnc_updateUiPreviewArea;

// Stop the progress update loop handle if any
private _handle = uiNamespace getVariable ["ZeusJukebox_previewUpdateHandle", scriptNull];
if (!isNull _handle) then {
	terminate _handle;
	uiNamespace setVariable ["ZeusJukebox_previewUpdateHandle", scriptNull];
};

true