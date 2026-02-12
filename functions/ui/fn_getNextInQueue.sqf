/*
 * Author: Eludage
 * Gets the next track from the queue and removes it.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * String: Class name of the next track, or empty string if queue is empty
 *
 * Example:
 * private _nextTrack = [] call ZeusJukebox_fnc_getNextInQueue;
 */

private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];

// Return empty string if queue is empty
if (count _queue == 0) exitWith { "" };

// Get first track from queue (it's an array: [className, displayName, duration])
private _nextTrackInfo = _queue select 0;
private _className = _nextTrackInfo select 0;

// Remove it from queue
_queue deleteAt 0;
missionNamespace setVariable ["ZeusJukebox_queue", _queue, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

_className
