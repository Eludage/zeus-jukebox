/*
 * Author: Eludage
 * Handles the add to queue button click for the preview track.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPreviewAddToQueue;
 */
disableSerialization;

// Get currently selected track from preview
private _selectedTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];

if (_selectedTrack == "") exitWith {
	false;
};

// Get track info using utility function
private _trackInfo = [_selectedTrack] call ZeusJukebox_fnc_getTrackConfig;
if (_trackInfo isEqualTo []) exitWith {
	false;
};

_trackInfo params ["_config", "_displayName", "_duration", "_soundFile"];

// Get current queue
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];

// Add track to end of queue [className, displayName, duration]
_queue pushBack [_selectedTrack, _displayName, _duration];

// Store updated queue
missionNamespace setVariable ["ZeusJukebox_queue", _queue, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

// Clear preview section using the shared function
[] call ZeusJukebox_fnc_clearPreviewArea;

// Show feedback
private _durationStr = [_duration] call ZeusJukebox_fnc_formatDuration;

// Check autoplay (if enabled and Currently Playing is empty)
[] call ZeusJukebox_fnc_checkAutoplay;

true;