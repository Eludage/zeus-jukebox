/*
 * Author: Eludage
 * Deletes the selected playlist. No confirmation prompt, matches the existing
 * Clear History button behavior.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlaylistDelete;
 */

disableSerialization;

private _selectedName = uiNamespace getVariable ["ZeusJukebox_selectedPlaylistName", ""];
if (_selectedName == "") exitWith { false };

private _playlists = uiNamespace getVariable ["ZeusJukebox_playlists", []];

private _idx = -1;
{
    if ((_x select 0) == _selectedName) exitWith { _idx = _forEachIndex; };
} forEach _playlists;
if (_idx == -1) exitWith { false };

_playlists deleteAt _idx;

uiNamespace setVariable ["ZeusJukebox_selectedPlaylistName", ""];

[_playlists] call ZeusJukebox_fnc_savePlaylists;

[] call ZeusJukebox_fnc_updateUiManageSongLists;

true
