/*
 * Author: Eludage
 * Handles queue entry selection to update queue buttons state.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onQueueEntrySelected;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _queueList = _display displayCtrl 15704;
if (isNull _queueList) exitWith { false };

// Capture current selection before updateUiQueue clears and rebuilds
private _curSel = lbCurSel _queueList;
private _selectedTrack = "";
private _selectedIdx = -1;

if (_curSel >= 0) then {
	_selectedTrack = _queueList lbData _curSel;
	_selectedIdx = _curSel;
};

// Store selected track and index in namespace so updateUiQueue can restore it
uiNamespace setVariable ["ZeusJukebox_selectedQueueTrack", _selectedTrack];
uiNamespace setVariable ["ZeusJukebox_selectedQueueIdx", _selectedIdx];

[] call ZeusJukebox_fnc_updateUiQueue;

true