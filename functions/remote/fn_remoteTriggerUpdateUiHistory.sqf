/*
 * Author: Eludage
 * Remote execution function to synchronize ui track history and the played-track
 * highlight in the Available Music list across all Zeus clients.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_remoteTriggerUpdateUiHistory;
 */
disableSerialization;

private _registeredZeuses = missionNamespace getVariable ["ZeusJukebox_registeredZeuses", []];
{
	[] remoteExec ["ZeusJukebox_fnc_updateUiHistory", _x, false];
	[] remoteExec ["ZeusJukebox_fnc_updateUiMusicList", _x, false];
} forEach _registeredZeuses;

true
