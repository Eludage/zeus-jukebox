/*
 * Author: Eludage
 * Persists the playlists array to profileNamespace and refreshes the uiNamespace cache.
 *
 * Arguments:
 * 0: Array of [name, classNames] playlist records <ARRAY>
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [_playlists] call ZeusJukebox_fnc_savePlaylists;
 */

params [["_playlists", [], [[]]]];

uiNamespace setVariable ["ZeusJukebox_playlists", _playlists];
profileNamespace setVariable ["ZeusJukebox_playlists", _playlists];
saveProfileNamespace;

true
