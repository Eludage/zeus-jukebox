/*
 * Author: Eludage
 * Unregisters the current Zeus player when closing the dialog.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_unregisterZeus;
 */

private _registeredZeuses = missionNamespace getVariable ["ZeusJukebox_registeredZeuses", []];

// Remove player from the list
_registeredZeuses = _registeredZeuses - [player];
missionNamespace setVariable ["ZeusJukebox_registeredZeuses", _registeredZeuses, true];


true
