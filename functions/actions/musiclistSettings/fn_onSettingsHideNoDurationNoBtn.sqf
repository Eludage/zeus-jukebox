/*
 * Author: Eludage
 * Handles the "Hiding Music with no duration: No" button click to start hiding them.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onSettingsHideNoDurationNoBtn;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

uiNamespace setVariable ["ZeusJukebox_hideNoDuration", true];

private _btnYes = _display displayCtrl 15822;
private _btnNo = _display displayCtrl 15823;
if (!isNull _btnYes) then { _btnYes ctrlShow true; };
if (!isNull _btnNo) then { _btnNo ctrlShow false; };

[] call ZeusJukebox_fnc_updateUiMusicList;

true
