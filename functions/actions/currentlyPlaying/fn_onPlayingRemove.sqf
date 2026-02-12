/*
 * Author: Eludage
 * Handles the remove button click to clear the currently playing track.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlayingRemove;
 */
disableSerialization;

// Remove currently playing song (handles stopping music, clearing state, and UI updates)
[] call ZeusJukebox_fnc_remoteRemoveSong;

true;
