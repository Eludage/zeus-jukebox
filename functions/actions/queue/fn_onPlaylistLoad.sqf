/*
 * Author: Eludage
 * Appends the selected playlist's tracks to the current queue and broadcasts
 * the update to all Zeuses.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlaylistLoad;
 */

disableSerialization;

private _selectedName = uiNamespace getVariable ["ZeusJukebox_selectedPlaylistName", ""];
if (_selectedName == "") exitWith { false };

private _playlists = uiNamespace getVariable ["ZeusJukebox_playlists", []];

private _classNames = [];
{
    if ((_x select 0) == _selectedName) exitWith { _classNames = _x select 1; };
} forEach _playlists;
if (count _classNames == 0) exitWith { false };

[_classNames] call ZeusJukebox_fnc_remoteAddClassNamesToQueue;

true
