/*
 * Author: Eludage
 * Handles the move down button click to move the selected queue entry down.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onQueueDown;
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

// Get queue data
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
private _queueCount = count _queue;

if (_selectedIdx >= _queueCount - 1) exitWith {
	false
};

// Swap with item below
private _temp = _queue select (_selectedIdx + 1);
_queue set [_selectedIdx + 1, _queue select _selectedIdx];
_queue set [_selectedIdx, _temp];

missionNamespace setVariable ["ZeusJukebox_queue", _queue, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

// Keep selection on the moved item
_queueList lbSetCurSel (_selectedIdx + 1);

true;