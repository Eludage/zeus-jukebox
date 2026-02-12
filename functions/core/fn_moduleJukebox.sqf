/*
 * Author: Eludage
 * Zeus module function that opens the Jukebox dialog
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic, [], true] call ZeusJukebox_fnc_moduleJukebox;
 */

params ["_logic", "_units", "_activated"];

if (!_activated) exitWith {};

// Open the dialog on the client (Zeus curator)
[] call ZeusJukebox_fnc_openJukeboxDialog;

// Delete the logic object (it's just a trigger)
deleteVehicle _logic;
