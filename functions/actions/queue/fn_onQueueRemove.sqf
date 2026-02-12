/*
 * Author: Eludage
 * Handles the remove button click for the selected queue entry.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onQueueRemove;
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
if (_selectedIdx >= count _queue) exitWith { false };

// Get track name for feedback
private _trackInfo = _queue select _selectedIdx;
private _displayName = _trackInfo select 1;

// Remove from queue
_queue deleteAt _selectedIdx;
missionNamespace setVariable ["ZeusJukebox_queue", _queue, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

// Try to keep selection at same index or move up
private _newCount = count _queue;
if (_newCount > 0) then {
    private _newIdx = _selectedIdx min (_newCount - 1);
    _queueList lbSetCurSel _newIdx;
};

true;