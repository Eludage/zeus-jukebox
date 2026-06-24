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

private _overlayIdcs = [
    15800, 15801, 15802, 15803,
    15811, 15812, 15813, 15814, 15815,
    15821, 15822, 15823,
    15831, 15832, 15833
];
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlShow false; };
} forEach _overlayIdcs;

true
