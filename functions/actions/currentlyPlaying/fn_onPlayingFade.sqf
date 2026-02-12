/*
 * Author: Eludage
 * Handles the fade out button click for the currently playing track.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlayingFade;
 */
disableSerialization;

[] call ZeusJukebox_fnc_remoteFadeSong;
true;