/*
 * Author: Eludage
 * Handles the "Alphabetically" sort button click to switch sorting to by Time.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onSettingsSortAlphabeticalBtn;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

uiNamespace setVariable ["ZeusJukebox_sortMode", "time"];

private _btnAlphabetical = _display displayCtrl 15812;
private _btnByTime = _display displayCtrl 15813;
if (!isNull _btnAlphabetical) then { _btnAlphabetical ctrlShow false; };
if (!isNull _btnByTime) then { _btnByTime ctrlShow true; };

[] call ZeusJukebox_fnc_updateUiMusicList;

true
