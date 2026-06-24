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

// Clear before the restore calls below, so fn_updateUiCurrentlyPlaying.sqf /
// fn_updateUiQueue.sqf actually re-enable their buttons instead of skipping it.
uiNamespace setVariable ["ZeusJukebox_settingsOverlayOpen", false];

private _overlayIdcs = [
    15800, 15801, 15802, 15803, 15804,
    15811, 15812, 15813, 15814, 15815,
    15821, 15822, 15823,
    15831, 15832, 15833
];
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlShow false; };
} forEach _overlayIdcs;

// Re-enable every control that was disabled in onMusicListSettings.sqf when the
// overlay opened. Must mirror that IDC list exactly.
private _enableIdcs = [
    // Preview
    15304, 15306, 15307, 15308, 15309, 15311, 15312,
    // Options
    15402, 15403, 15404, 15405, 15406,
    // Music List (gear button included)
    15502, 15503, 15505, 15506, 15507, 15508, 15509, 15510, 15511,
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
// state, so it doesn't get stuck enabled when it shouldn't be. These already read
// purely from namespace (never from controls), so calling them here is safe and
// matches how they're already invoked elsewhere (e.g. fn_openJukeboxDialog.sqf).
[0] call ZeusJukebox_fnc_changeFontSize;          // restores 15402/15403 min/max state
[] call ZeusJukebox_fnc_updateUiCurrentlyPlaying; // restores 15605-15608 (incl. ACE fade check)
[] call ZeusJukebox_fnc_updateUiQueue;            // restores 15705-15709 selection-dependent state

true
