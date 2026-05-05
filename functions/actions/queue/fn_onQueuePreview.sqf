/*
 * Author: Eludage
 * Handles the preview button click for the selected queue entry.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onQueuePreview;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _queueList = _display displayCtrl 15704;
if (isNull _queueList) exitWith { false };

private _selectedIdx = lbCurSel _queueList;
if (_selectedIdx < 0) exitWith {
	false
};

// Get track class name from listbox data
private _className = _queueList lbData _selectedIdx;
if (_className == "") exitWith { false };

// Get sound file from queue array
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
if (_selectedIdx >= count _queue) exitWith { false };
private _trackEntry = _queue select _selectedIdx;
private _soundFile = if (count _trackEntry > 3) then { _trackEntry select 3 } else { "" };
private _duration = if (count _trackEntry > 2) then { _trackEntry select 2 } else { 0 };

// Stop any current preview playback
private _isPreviewPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];
if (_isPreviewPlaying) then {
    playMusic "";
    // Stop update handle
    private _handle = uiNamespace getVariable ["ZeusJukebox_previewUpdateHandle", scriptNull];
    if (!isNull _handle) then {
        terminate _handle;
        uiNamespace setVariable ["ZeusJukebox_previewUpdateHandle", scriptNull];
    };
};

// Load song into preview by setting uiNamespace and updating UI
uiNamespace setVariable ["ZeusJukebox_selectedMusicListTrack", _className];
uiNamespace setVariable ["ZeusJukebox_previewTrack", _className];
uiNamespace setVariable ["ZeusJukebox_previewSoundFile", _soundFile];
uiNamespace setVariable ["ZeusJukebox_previewPlaying", false];
uiNamespace setVariable ["ZeusJukebox_previewStartTime", 0];
uiNamespace setVariable ["ZeusJukebox_previewPausedAt", 0];
uiNamespace setVariable ["ZeusJukebox_previewDuration", _duration];

// Update Track Info section
[_className, _soundFile] call ZeusJukebox_fnc_updateUiTrackInfo;

// Update Preview area
[] call ZeusJukebox_fnc_updateUiPreviewArea;

// If autoplay preview is enabled, immediately start playing the new track
if (uiNamespace getVariable ["ZeusJukebox_autoplayPreview", false]) then {
	[] call ZeusJukebox_fnc_onPreviewPlay;
};