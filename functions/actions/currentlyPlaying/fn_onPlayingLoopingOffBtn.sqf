/*
 * Author: Eludage
 * Handles the looping off button click to enable looping for the currently playing track.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlayingLoopingOffBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

missionNamespace setVariable ["ZeusJukebox_looping", true, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiCurrentlyPlaying;

true;