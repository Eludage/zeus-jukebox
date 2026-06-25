/*
 * Author: Eludage
 * Handles the "Hiding blacklisted Music: No" button click to start hiding them.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onSettingsHideBlacklistedNoBtn;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

uiNamespace setVariable ["ZeusJukebox_hideBlacklisted", true];

private _btnYes = _display displayCtrl 15832;
private _btnNo = _display displayCtrl 15833;
if (!isNull _btnYes) then { _btnYes ctrlShow true; };
if (!isNull _btnNo) then { _btnNo ctrlShow false; };

[] call ZeusJukebox_fnc_updateUiMusicList;

true
