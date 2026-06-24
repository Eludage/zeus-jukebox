/*
 * Author: Eludage
 * Handles the "by Time" sort button click to switch sorting to Alphabetical.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onSettingsSortByTimeBtn;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

uiNamespace setVariable ["ZeusJukebox_sortMode", "alphabetical"];

private _btnAlphabetical = _display displayCtrl 15812;
private _btnByTime = _display displayCtrl 15813;
if (!isNull _btnAlphabetical) then { _btnAlphabetical ctrlShow true; };
if (!isNull _btnByTime) then { _btnByTime ctrlShow false; };

true
