/*
 * Author: Eludage
 * Remote execution function to synchronize ui queue state across all Zeus clients.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;
 */
disableSerialization;

private _registeredZeuses = missionNamespace getVariable ["ZeusJukebox_registeredZeuses", []];
{
	[] remoteExec ["ZeusJukebox_fnc_updateUiQueue", _x, false];
} forEach _registeredZeuses;

true