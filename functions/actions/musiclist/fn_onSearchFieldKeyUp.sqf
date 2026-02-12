/*
 * Author: Eludage
 * Handles search field key up events to filter the music list.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onSearchFieldKeyUp;
 */
disableSerialization;

// Refresh the music list based on the current search field value
[] call ZeusJukebox_fnc_updateUiMusicList;
true;