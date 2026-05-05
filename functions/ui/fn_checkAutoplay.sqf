/*
 * Author: Eludage
 * Checks if autoplay should trigger - plays the top queue item if:
 * - Autoplay is enabled
 * - Currently Playing is empty
 * - Queue has at least one item
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true if autoplay triggered, false otherwise
 *
 * Example:
 * [] call ZeusJukebox_fnc_checkAutoplay;
 */

// Check if autoplay is enabled
private _isAutoplay = missionNamespace getVariable ["ZeusJukebox_autoplay", false];
if (!_isAutoplay) exitWith { false };

// Check if Currently Playing is empty
private _currentTrack = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];
if (_currentTrack != "") exitWith { false };

// Check if queue has items
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
if (count _queue == 0) exitWith { false };

// Get next track from queue (returns full entry array)
private _nextTrackInfo = [] call ZeusJukebox_fnc_getNextInQueue;
if (count _nextTrackInfo == 0) exitWith { false };

_nextTrackInfo params ["_className", "_displayName", "_duration"];
private _soundFile = if (count _nextTrackInfo > 3) then { _nextTrackInfo select 3 } else { "" };

// Play the song for all clients (remotePlaySong handles all state setup)
[_className, 0, _soundFile] call ZeusJukebox_fnc_remotePlaySong;

true
