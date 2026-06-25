/*
 * Author: Eludage
 * Shows the Track History overlay on top of the open Jukebox dialog.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onTrackHistoryOpen;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Flag checked by fn_updateUiCurrentlyPlaying.sqf / fn_updateUiQueue.sqf so externally
// triggered refreshes don't silently re-enable buttons disabled below while this is open.
uiNamespace setVariable ["ZeusJukebox_historyOverlayOpen", true];

private _overlayIdcs = [15900, 15901, 15902, 15903, 15904, 15905, 15906];
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlShow true; };
} forEach _overlayIdcs;

// Populate with the latest history data every time the overlay opens
[] call ZeusJukebox_fnc_updateUiHistory;

// Disable every interactive control elsewhere in the dialog so it can't be used
// while the overlay is open (re-enabled in onTrackHistoryClose.sqf). Mirrors the
// blocking mechanism used by onMusicListSettings.sqf.
private _disableIdcs = [
    // Preview
    15304, 15306, 15307, 15308, 15309, 15311, 15312,
    // Options
    15402, 15403, 15404, 15405, 15406,
    // Music List (including the gear button and the History button itself, so
    // neither can be re-clicked while this overlay is already showing)
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

// Move focus off the History button and onto the overlay's close button so it
// doesn't stay highlighted/re-triggerable while the overlay is open
private _closeButton = _display displayCtrl 15903;
if (!isNull _closeButton) then { ctrlSetFocus _closeButton; };

true
