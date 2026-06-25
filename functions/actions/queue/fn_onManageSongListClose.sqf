/*
 * Author: Eludage
 * Hides the Manage Song Lists overlay shown by ZeusJukebox_fnc_onManageSongList.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onManageSongListClose;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Clear before the restore calls below, so fn_updateUiCurrentlyPlaying.sqf /
// fn_updateUiQueue.sqf actually re-enable their buttons instead of skipping it.
uiNamespace setVariable ["ZeusJukebox_manageSongListsOverlayOpen", false];

private _overlayIdcs = [
    16000, 16001, 16002, 16003, 16004,
    16010, 16011, 16012, 16013,
    16020, 16021, 16022, 16023, 16024
];
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlShow false; };
} forEach _overlayIdcs;

// Clear the name field and selection state for next time the overlay opens
private _nameField = _display displayCtrl 16011;
if (!isNull _nameField) then { _nameField ctrlSetText ""; };
uiNamespace setVariable ["ZeusJukebox_selectedPlaylistName", ""];

// Re-enable every control that was disabled in onManageSongList.sqf when the
// overlay opened. Must mirror that IDC list exactly.
private _enableIdcs = [
    // Preview
    15304, 15306, 15307, 15308, 15309, 15311, 15312,
    // Options
    15402, 15403, 15404, 15405, 15406,
    // Music List (gear button and History button included)
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
    if (!isNull _ctrl) then { _ctrl ctrlEnable true; };
} forEach _enableIdcs;

// The blanket enable above resets every control to "enabled". Re-run the existing
// UI update functions for sections that have namespace-driven conditional enable
// state, so it doesn't get stuck enabled when it shouldn't be.
[0] call ZeusJukebox_fnc_changeFontSize;          // restores 15402/15403 min/max state
[] call ZeusJukebox_fnc_updateUiCurrentlyPlaying; // restores 15605-15608 (incl. ACE fade check)
[] call ZeusJukebox_fnc_updateUiQueue;            // restores 15705-15709 selection-dependent state

true
