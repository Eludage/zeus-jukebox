/*
 * Author: Eludage
 * Handles the autoplay on button click to disable autoplay.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onQueueAutoplayOnBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

missionNamespace setVariable ["ZeusJukebox_autoplay", true, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;


// Trigger check to start playing if needed
[] call ZeusJukebox_fnc_checkAutoplay;

true;