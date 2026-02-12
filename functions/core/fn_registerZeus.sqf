/*
 * Author: Eludage
 * Registers the current Zeus player as having the dialog open.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_registerZeus;
 */

private _registeredZeuses = missionNamespace getVariable ["ZeusJukebox_registeredZeuses", []];

// Check if player is already registered
if (player in _registeredZeuses) exitWith { true };

// Add player to the list
_registeredZeuses pushBack player;
missionNamespace setVariable ["ZeusJukebox_registeredZeuses", _registeredZeuses, true];


true
