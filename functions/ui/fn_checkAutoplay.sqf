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

// Get next track from queue
private _nextTrack = [] call ZeusJukebox_fnc_getNextInQueue;
if (_nextTrack == "") exitWith { false };

// Play the song for all clients (remotePlaySong handles all state setup)
[_nextTrack, 0] call ZeusJukebox_fnc_remotePlaySong;


true
