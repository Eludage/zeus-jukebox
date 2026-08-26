/*
 * Author: Eludage
 * Overwrites the selected playlist's tracks with the current queue's contents.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlaylistUpdateSelected;
 */

disableSerialization;

private _selectedName = uiNamespace getVariable ["ZeusJukebox_selectedPlaylistName", ""];
if (_selectedName == "") exitWith { false };

private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
if (count _queue == 0) exitWith { false };

private _playlists = uiNamespace getVariable ["ZeusJukebox_playlists", []];

private _idx = -1;
{
    if ((_x select 0) == _selectedName) exitWith { _idx = _forEachIndex; };
} forEach _playlists;
if (_idx == -1) exitWith { false };

private _classNames = _queue apply { _x select 0 };
_playlists set [_idx, [_selectedName, _classNames]];

[_playlists] call ZeusJukebox_fnc_savePlaylists;

[] call ZeusJukebox_fnc_updateUiManageSongLists;

true
