/*
 * Author: Eludage
 * Clears the Currently Playing section UI and state.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_clearCurrentlyPlaying;
 */

disableSerialization;

// Clear all Currently Playing state
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingTrack", "", true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingActive", false, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingStartTime", 0, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingPausedAt", 0, true];
missionNamespace setVariable ["ZeusJukebox_currentlyPlayingDuration", 0, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiCurrentlyPlaying;

true;