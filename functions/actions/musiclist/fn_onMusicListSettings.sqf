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

// Flag checked by fn_updateUiCurrentlyPlaying.sqf / fn_updateUiQueue.sqf so externally
// triggered refreshes (the playback-progress loop, other Zeus clients' remote
// triggers) don't silently re-enable buttons disabled below while this is open.
uiNamespace setVariable ["ZeusJukebox_settingsOverlayOpen", true];

private _overlayIdcs = [15800, 15801, 15802, 15803, 15804, 15811, 15821, 15831];
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlShow true; };
} forEach _overlayIdcs;

// Disable every interactive control elsewhere in the dialog so it can't be used
// while the overlay is open (re-enabled in onMusicListSettingsClose.sqf). This is
// the actual interaction-blocking mechanism - see SettingsOverlayDim in dialogs.hpp
// for why a dim panel alone (no click-blocker buttons) is not enough.
private _disableIdcs = [
    // Preview
    15304, 15306, 15307, 15308, 15309, 15311, 15312,
    // Options
    15402, 15403, 15404, 15405, 15406,
    // Music List (including the gear button itself, idc 15511, so it can't be
    // re-clicked while its own overlay is already showing)
    15502, 15503, 15505, 15506, 15507, 15508, 15509, 15510, 15511, 15512,
    // Currently Playing
    15605, 15606, 15607, 15608, 15609, 15610, 15611, 15612,
    // Queue
    15702, 15703, 15704, 15705, 15706, 15707, 15708, 15709, 15710,
    // Dialog chrome
    15011
];
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlEnable false; };
} forEach _disableIdcs;

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

// Move focus off the gear button and onto the overlay's close button so it
// doesn't stay highlighted/re-triggerable while the overlay is open
private _closeButton = _display displayCtrl 15803;
if (!isNull _closeButton) then { ctrlSetFocus _closeButton; };

true
