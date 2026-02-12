/*
 * Author: Eludage
 * Remote execution function to synchronize ui queue state across all Zeus clients.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_updateUiQueue;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _queueList = _display displayCtrl 15704;
if (isNull _queueList) exitWith { false };

// Get queue data from missionNamespace
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
private _autoplay = missionNamespace getVariable ["ZeusJukebox_autoplay", false];

// Clear existing items
lbClear _queueList;

// Get currently selected item to restore selection later
private _previousSelected = uiNamespace getVariable ["ZeusJukebox_selectedQueueTrack", ""];
private _previousIdx = uiNamespace getVariable ["ZeusJukebox_selectedQueueIdx", -1];
private _newSelectedIdx = -1;

// Populate queue listbox
{
    _x params ["_className", "_displayName", "_duration"];

    private _durationStr = [_duration] call ZeusJukebox_fnc_formatDuration;
    private _text = format ["%1 (%2)", _displayName, _durationStr];

    private _idx = _queueList lbAdd _text;
    _queueList lbSetData [_idx, _className];
	
	// Restore selection: prefer exact index+className match, then just index
	if (_newSelectedIdx < 0) then {
		if (_previousIdx == _idx && _className == _previousSelected) then {
			_newSelectedIdx = _idx;
		} else {
			if (_previousIdx == _idx) then {
				_newSelectedIdx = _idx;
			};
		};
	};
} forEach _queue;

// Restore selection
if (_newSelectedIdx >= 0) then {
	_queueList lbSetCurSel _newSelectedIdx;
};

// Update Autoplay button state
private _btnAutoplayOff = _display displayCtrl 15702;
private _btnAutoplayOn = _display displayCtrl 15703;
if (!isNull _btnAutoplayOff) then { _btnAutoplayOff ctrlShow !_autoplay; };
if (!isNull _btnAutoplayOn) then { _btnAutoplayOn ctrlShow _autoplay; };

// Update queue button states
private _queueCount = count _queue;
private _hasSelection = (_newSelectedIdx >= 0) && (_newSelectedIdx < _queueCount);

// Get all button controls
private _btnPlay = _display displayCtrl 15705;
private _btnRemove = _display displayCtrl 15706;
private _btnPreview = _display displayCtrl 15707;
private _btnUp = _display displayCtrl 15708;
private _btnDown = _display displayCtrl 15709;

// Check if Currently Playing is empty (for Play button)
private _currentTrack = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];
private _currentlyPlayingEmpty = (_currentTrack == "");

// Update Play button - only enabled if selection exists AND Currently Playing is empty
if (!isNull _btnPlay) then {
    _btnPlay ctrlEnable (_hasSelection && _currentlyPlayingEmpty);
};

// Update Remove button - enabled if selection exists
if (!isNull _btnRemove) then {
    _btnRemove ctrlEnable _hasSelection;
};

// Update Preview button - enabled if selection exists
if (!isNull _btnPreview) then {
    _btnPreview ctrlEnable _hasSelection;
};

// Update Up button - enabled if selection exists and not at top
if (!isNull _btnUp) then {
    _btnUp ctrlEnable (_hasSelection && _newSelectedIdx > 0);
};

// Update Down button - enabled if selection exists and not at bottom
if (!isNull _btnDown) then {
    _btnDown ctrlEnable (_hasSelection && _newSelectedIdx < (_queueCount - 1));
};

true