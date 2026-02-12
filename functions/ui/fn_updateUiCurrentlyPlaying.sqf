/*
 * Author: Eludage
 * Updates the UI to reflect the currently playing track status.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_updateUiCurrentlyPlaying;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Get all missionNamespace variables
private _currentTrack = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];
private _isActive = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingActive", false];
private _startTime = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingStartTime", 0];
private _duration = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingDuration", 0];
private _looping = missionNamespace getVariable ["ZeusJukebox_looping", false];
private _isFading = missionNamespace getVariable ["ZeusJukebox_isFading", false];

// Get uiNamespace variable for local listening state
private _isListening = uiNamespace getVariable ["ZeusJukebox_isListeningLocally", true];

// Get controls
private _noSongOverlay = _display displayCtrl 15613;
private _titleCtrl = _display displayCtrl 15601;
private _progressBg = _display displayCtrl 15602;
private _progressFill = _display displayCtrl 15603;
private _timeCtrl = _display displayCtrl 15604;
private _btnPlay = _display displayCtrl 15605;
private _btnStop = _display displayCtrl 15606;
private _btnFade = _display displayCtrl 15607;
private _btnRemove = _display displayCtrl 15608;
private _btnListenOff = _display displayCtrl 15609;
private _btnListenOn = _display displayCtrl 15610;
private _btnLoopOff = _display displayCtrl 15611;
private _btnLoopOn = _display displayCtrl 15612;

// If no track is loaded
if (_currentTrack == "") exitWith {
	// Show "No song selected" overlay
	if (!isNull _noSongOverlay) then { _noSongOverlay ctrlShow true; };
	
	// Hide all Currently Playing controls
	{
		private _ctrl = _display displayCtrl _x;
		if (!isNull _ctrl) then { _ctrl ctrlShow false; };
	} forEach [15601, 15602, 15603, 15604, 15605, 15606, 15607, 15608, 15609, 15610, 15611, 15612];
	
	// Disable buttons
	if (!isNull _btnPlay) then { _btnPlay ctrlEnable false; };
	if (!isNull _btnStop) then { _btnStop ctrlEnable false; };
	if (!isNull _btnRemove) then { _btnRemove ctrlEnable false; };
	
	true
};

// Track exists - hide overlay
if (!isNull _noSongOverlay) then { _noSongOverlay ctrlShow false; };

// Get track info from config
private _config = configFile >> "CfgMusic" >> _currentTrack;
if (!isClass _config) then {
	_config = missionConfigFile >> "CfgMusic" >> _currentTrack;
};

private _displayName = _currentTrack;
if (isClass _config) then {
	_displayName = getText (_config >> "name");
	if (_displayName == "") then { _displayName = _currentTrack; };
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
if (_isActive && _duration > 0) then {
	_elapsed = time - _startTime;
	_progress = (_elapsed / _duration) min 1.0;
} else {
	// When paused, show the paused position
	private _pausedAt = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingPausedAt", 0];
	_elapsed = _pausedAt;
	if (_duration > 0) then {
		_progress = (_pausedAt / _duration) min 1.0;
	};
};

// Update progress bar
if (!isNull _progressBg) then { _progressBg ctrlShow true; };
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

// Update Play/Stop button based on active state
if (!isNull _btnPlay) then {
	_btnPlay ctrlShow !_isActive;
	_btnPlay ctrlEnable true;
};
if (!isNull _btnStop) then {
	_btnStop ctrlShow _isActive;
	_btnStop ctrlEnable true;
};

// Update other buttons
if (!isNull _btnFade) then {
	_btnFade ctrlShow true;
	// Disable if: currently fading, not playing, or ACE Hearing is active
	private _aceHearingActive = (!isNil "ace_hearing_fnc_updateVolume" || isClass (configFile >> "CfgPatches" >> "ace_hearing"));
	private _canFade = _isActive && !_isFading && !_aceHearingActive;
	_btnFade ctrlEnable _canFade;
	if (_aceHearingActive && !_canFade) then {
		_btnFade ctrlSetTooltip "Disabled: ACE Hearing overrides music volume";
	} else {
		_btnFade ctrlSetTooltip "";
	};
};
if (!isNull _btnRemove) then {
	_btnRemove ctrlShow true;
	_btnRemove ctrlEnable true;
};

// Update Listen buttons based on local state
if (!isNull _btnListenOff) then {
	_btnListenOff ctrlShow !_isListening;
};
if (!isNull _btnListenOn) then {
	_btnListenOn ctrlShow _isListening;
};

// Update Loop buttons based on looping state
if (!isNull _btnLoopOff) then {
	_btnLoopOff ctrlShow !_looping;
};
if (!isNull _btnLoopOn) then {
	_btnLoopOn ctrlShow _looping;
};

true