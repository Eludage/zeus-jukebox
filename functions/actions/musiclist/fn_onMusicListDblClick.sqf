/*
 * Author: Eludage
 * Handles a double-click on the music list to immediately add the selected track to the queue.
 * Header/category entries are ignored.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onMusicListDblClick;
 */
disableSerialization;

// Prevent processing during list population
if (uiNamespace getVariable ["ZeusJukebox_isPopulating", false]) exitWith { false };

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _listBox = _display displayCtrl 15503;
if (isNull _listBox) exitWith { false };

private _selectedIndex = lbCurSel _listBox;
if (_selectedIndex < 0) exitWith { false };

// Ignore header/category entries
private _data = _listBox lbData _selectedIndex;
if (_data == "" || (_data select [0, 7]) == "HEADER:") exitWith { false };

// Parse className and soundFile from lbData ("className|soundFile")
private _dataParts = _data splitString "|";
private _className = _dataParts select 0;
private _soundFile = if (count _dataParts > 1) then { _dataParts select 1 } else { "" };
private _duration = _listBox lbValue _selectedIndex;

// Get display name from config (duration and soundFile already known from listbox)
private _trackInfo = [_className] call ZeusJukebox_fnc_getTrackConfig;
if (_trackInfo isEqualTo []) exitWith { false };
_trackInfo params ["", "_displayName", "", ""];

// Add to queue
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
_queue pushBack [_className, _displayName, _duration, _soundFile];
missionNamespace setVariable ["ZeusJukebox_queue", _queue, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

// Check autoplay
[] call ZeusJukebox_fnc_checkAutoplay;

true
