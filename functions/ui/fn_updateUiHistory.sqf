/*
 * Author: Eludage
 * Populates the Track History overlay listbox with previously played tracks,
 * newest first, showing duration and a relative "time ago" timestamp.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_updateUiHistory;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _historyList = _display displayCtrl 15905;
if (isNull _historyList) exitWith { false };

private _history = missionNamespace getVariable ["ZeusJukebox_trackHistory", []];

lbClear _historyList;

// Show newest plays first without mutating the shared missionNamespace array
private _historyReversed = +_history;
reverse _historyReversed;

{
	_x params [["_className", "", [""]], ["_displayName", "", [""]], ["_duration", 0, [0]], ["_soundFile", "", [""]], ["_playedAt", 0, [0]]];

	private _durationStr = [_duration] call ZeusJukebox_fnc_formatDuration;
	private _timeAgoStr = [_playedAt] call ZeusJukebox_fnc_formatTimeAgo;
	private _text = format ["%1 (%2) - %3", _displayName, _durationStr, _timeAgoStr];

	private _idx = _historyList lbAdd _text;
	_historyList lbSetData [_idx, _className + "|" + _soundFile];
} forEach _historyReversed;

true
