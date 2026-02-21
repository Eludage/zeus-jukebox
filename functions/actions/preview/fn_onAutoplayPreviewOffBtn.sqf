/*
 * Author: Eludage
 * Handles the "Autoplay Preview On" button click to disable autoplay preview.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onAutoplayPreviewOffBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Disable autoplay preview and let updateUiPreviewArea handle all UI
uiNamespace setVariable ["ZeusJukebox_autoplayPreview", false];
[] call ZeusJukebox_fnc_updateUiPreviewArea;

true
