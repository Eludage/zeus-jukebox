/*
 * Author: Eludage
 * Handles the "Descending" sort direction button click to switch to Ascending.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onSettingsSortDescendingBtn;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

uiNamespace setVariable ["ZeusJukebox_sortDirection", "ascending"];

private _btnAscending = _display displayCtrl 15814;
private _btnDescending = _display displayCtrl 15815;
if (!isNull _btnAscending) then { _btnAscending ctrlShow true; };
if (!isNull _btnDescending) then { _btnDescending ctrlShow false; };

true
