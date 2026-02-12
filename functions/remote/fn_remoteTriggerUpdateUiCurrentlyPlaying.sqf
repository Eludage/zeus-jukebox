/*
 * Author: Eludage
 * Remote execution function to synchronize ui currently playing state across all Zeus clients.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_remoteTriggerUpdateUiCurrentlyPlaying;
 */
disableSerialization;

private _registeredZeuses = missionNamespace getVariable ["ZeusJukebox_registeredZeuses", []];
{
	[] remoteExec ["ZeusJukebox_fnc_updateUiCurrentlyPlaying", _x, false];
} forEach _registeredZeuses;

true