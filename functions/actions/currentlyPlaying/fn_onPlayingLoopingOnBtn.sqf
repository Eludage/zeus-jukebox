/*
 * Author: Eludage
 * Handles the looping on button click to disable looping for the currently playing track.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlayingLoopingOnBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _btnOff = _display displayCtrl 15611;
private _btnOn = _display displayCtrl 15612;

if (isNull _btnOff || isNull _btnOn) exitWith { false };
_btnOff ctrlShow true;
_btnOn ctrlShow false;

missionNamespace setVariable ["ZeusJukebox_looping", false, true];

true;