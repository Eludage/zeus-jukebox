/*
 * Author: Eludage
 * Loads the saved playlists list from profileNamespace
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Array - Array of [name, classNames] playlist records
 *
 * Example:
 * [] call ZeusJukebox_fnc_loadPlaylists;
 */

private _playlists = profileNamespace getVariable ["ZeusJukebox_playlists", []];
_playlists
