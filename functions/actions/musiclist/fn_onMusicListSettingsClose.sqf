/*
 * Author: Eludage
 * Hides the Music List Settings overlay shown by ZeusJukebox_fnc_onMusicListSettings.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onMusicListSettingsClose;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _blocker = _display displayCtrl 15800;
private _background = _display displayCtrl 15801;
private _closeButton = _display displayCtrl 15802;
if (isNull _blocker || isNull _background || isNull _closeButton) exitWith { false };

_blocker ctrlShow false;
_background ctrlShow false;
_closeButton ctrlShow false;

true
