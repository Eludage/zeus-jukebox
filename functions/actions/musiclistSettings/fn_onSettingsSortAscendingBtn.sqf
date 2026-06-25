/*
 * Author: Eludage
 * Handles the "Ascending" sort direction button click to switch to Descending.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onSettingsSortAscendingBtn;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

uiNamespace setVariable ["ZeusJukebox_sortDirection", "descending"];

private _btnAscending = _display displayCtrl 15814;
private _btnDescending = _display displayCtrl 15815;
if (!isNull _btnAscending) then { _btnAscending ctrlShow false; };
if (!isNull _btnDescending) then { _btnDescending ctrlShow true; };

[] call ZeusJukebox_fnc_updateUiMusicList;

true
