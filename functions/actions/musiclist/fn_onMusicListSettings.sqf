/*
 * Author: Eludage
 * Shows the Music List Settings overlay on top of the open Jukebox dialog.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onMusicListSettings;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _overlayIdcs = [15800, 15801, 15802, 15803, 15811, 15821, 15831];
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlShow true; };
} forEach _overlayIdcs;

// Show the correct side of each toggle pair based on stored preferences
private _sortMode = uiNamespace getVariable ["ZeusJukebox_sortMode", "alphabetical"];
private _sortDirection = uiNamespace getVariable ["ZeusJukebox_sortDirection", "ascending"];
private _hideNoDuration = uiNamespace getVariable ["ZeusJukebox_hideNoDuration", false];
private _hideBlacklisted = uiNamespace getVariable ["ZeusJukebox_hideBlacklisted", false];

private _togglePairs = [
    [15812, 15813, _sortMode == "alphabetical"],  // Alphabetically / by Time
    [15814, 15815, _sortDirection == "ascending"], // Ascending / Descending
    [15822, 15823, _hideNoDuration],               // Yes / No
    [15832, 15833, _hideBlacklisted]               // Yes / No
];
{
    _x params ["_idcWhenTrue", "_idcWhenFalse", "_conditionTrue"];
    private _ctrlTrue = _display displayCtrl _idcWhenTrue;
    private _ctrlFalse = _display displayCtrl _idcWhenFalse;
    if (!isNull _ctrlTrue) then { _ctrlTrue ctrlShow _conditionTrue; };
    if (!isNull _ctrlFalse) then { _ctrlFalse ctrlShow !_conditionTrue; };
} forEach _togglePairs;

true
