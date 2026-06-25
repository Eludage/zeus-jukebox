/*
 * Author: Eludage
 * Handles a double-click on the Track History list to immediately add the
 * selected track back to the queue.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onTrackHistoryDblClick;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _listBox = _display displayCtrl 15905;
if (isNull _listBox) exitWith { false };

private _selectedIndex = lbCurSel _listBox;
if (_selectedIndex < 0) exitWith { false };

// Parse className and soundFile from lbData ("className|soundFile")
private _data = _listBox lbData _selectedIndex;
private _dataParts = _data splitString "|";
private _className = _dataParts select 0;
private _soundFile = if (count _dataParts > 1) then { _dataParts select 1 } else { "" };

// Get display name and duration from config — keep the soundFile from the
// history entry itself (the exact file that was actually played), rather than
// the one getTrackConfig resolves now, to avoid mission/addon classname-shadowing
// ambiguity if the same class name exists in both.
private _trackInfo = [_className] call ZeusJukebox_fnc_getTrackConfig;
if (_trackInfo isEqualTo []) exitWith { false };
_trackInfo params ["", "_displayName", "_duration", ""];

// Add to queue
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
_queue pushBack [_className, _displayName, _duration, _soundFile];
missionNamespace setVariable ["ZeusJukebox_queue", _queue, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

// Check autoplay
[] call ZeusJukebox_fnc_checkAutoplay;

true
