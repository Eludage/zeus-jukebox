/*
 * Author: Eludage
 * Handles the remove button click to clear the preview area.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPreviewRemove;
 */
disableSerialization;

// Clear the preview area
[] call ZeusJukebox_fnc_clearPreviewArea;
true;