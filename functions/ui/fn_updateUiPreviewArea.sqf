/*
 * Function: ZeusJukebox_fnc_updateUiPreviewArea
 * Description: Updates the preview area UI based on uiNamespace variables
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_updateUiPreviewArea;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Get preview state from uiNamespace
private _previewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
private _isPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];
private _startTime = uiNamespace getVariable ["ZeusJukebox_previewStartTime", 0];
private _pausedAt = uiNamespace getVariable ["ZeusJukebox_previewPausedAt", 0];

// Get controls
private _noSongText = _display displayCtrl 15301;
private _titleCtrl = _display displayCtrl 15310;
private _progressBg = _display displayCtrl 15302;
private _progressFill = _display displayCtrl 15303;
private _progressClick = _display displayCtrl 15304;
private _timeCtrl = _display displayCtrl 15305;
private _btnPlay = _display displayCtrl 15306;
private _btnPause = _display displayCtrl 15307;
private _btnRemove = _display displayCtrl 15308;
private _btnAddToQueue = _display displayCtrl 15309;

// If no preview track loaded
if (_previewTrack == "") exitWith {
	// Show "No Song selected" text
	if (!isNull _noSongText) then { _noSongText ctrlShow true; };
	
	// Hide all preview controls
	{
		private _ctrl = _display displayCtrl _x;
		if (!isNull _ctrl) then { _ctrl ctrlShow false; };
	} forEach [15310, 15302, 15303, 15304, 15305, 15306, 15307, 15308, 15309];
	
	true
};

// Track exists - hide "No song selected" text
if (!isNull _noSongText) then { _noSongText ctrlShow false; };

// Get track info from uiNamespace
private _duration = uiNamespace getVariable ["ZeusJukebox_previewDuration", 0];

// Get display name from musicTracks HashMap if available
private _musicTracks = uiNamespace getVariable ["ZeusJukebox_musicTracks", createHashMap];
private _trackData = _musicTracks get _previewTrack;

private _displayName = _previewTrack;
if (!isNil "_trackData") then {
	_trackData params ["_name", "_dur", "_file", "_theme", "_isMission"];
	if (_name != "") then { _displayName = _name; };
};

// Update title with track name and duration
private _durationStr = [_duration] call ZeusJukebox_fnc_formatDuration;
if (!isNull _titleCtrl) then {
	_titleCtrl ctrlSetText format ["%1 (%2)", _displayName, _durationStr];
	_titleCtrl ctrlShow true;
};

// Calculate elapsed time and progress
private _elapsed = 0;
private _progress = 0;
if (_isPlaying && _duration > 0) then {
	_elapsed = time - _startTime;
	_progress = (_elapsed / _duration) min 1.0;
} else {
	// Use paused position
	_elapsed = _pausedAt;
	if (_duration > 0) then {
		_progress = (_pausedAt / _duration) min 1.0;
	};
};

// Update progress bar
if (!isNull _progressBg) then { _progressBg ctrlShow true; };
if (!isNull _progressClick) then { _progressClick ctrlShow true; };
if (!isNull _progressFill) then {
	_progressFill ctrlShow true;
	private _fillPos = ctrlPosition _progressFill;
	private _bgPos = ctrlPosition _progressBg;
	_fillPos set [0, _bgPos select 0];  // Match background X position
	_fillPos set [1, _bgPos select 1];  // Match background Y position
	_fillPos set [2, (_bgPos select 2) * _progress];  // Width based on progress
	_fillPos set [3, _bgPos select 3];  // Match background height
	_progressFill ctrlSetPosition _fillPos;
	_progressFill ctrlCommit 0;
};

// Update time text
private _elapsedStr = [_elapsed] call ZeusJukebox_fnc_formatDuration;
if (!isNull _timeCtrl) then {
	_timeCtrl ctrlSetText format ["%1 / %2", _elapsedStr, _durationStr];
	_timeCtrl ctrlShow true;
};

// Update Play/Pause button based on playing state
if (!isNull _btnPlay) then {
	_btnPlay ctrlShow !_isPlaying;
};
if (!isNull _btnPause) then {
	_btnPause ctrlShow _isPlaying;
};

// Show other buttons
if (!isNull _btnRemove) then { _btnRemove ctrlShow true; };
if (!isNull _btnAddToQueue) then { _btnAddToQueue ctrlShow true; };

true