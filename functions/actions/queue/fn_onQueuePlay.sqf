/*
 * Author: Eludage
 * Handles the play button click for the selected queue entry.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onQueuePlay;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Check if Currently Playing is empty
private _currentTrack = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];
if (_currentTrack != "") exitWith {
	false
};

private _queueList = _display displayCtrl 15704;
if (isNull _queueList) exitWith { false };

private _selectedIdx = lbCurSel _queueList;
if (_selectedIdx < 0) exitWith {
	false
};

// Get queue data
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
if (_selectedIdx >= count _queue) exitWith { false };

// Get track info from queue
private _trackInfo = _queue select _selectedIdx;
_trackInfo params ["_className", "_displayName", "_duration"];

// Remove from queue
_queue deleteAt _selectedIdx;
missionNamespace setVariable ["ZeusJukebox_queue", _queue, true];

// Trigger queue UI update
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

// Play the song for all clients (this handles all Currently Playing state setup)
[_className, 0] call ZeusJukebox_fnc_remotePlaySong;

true

