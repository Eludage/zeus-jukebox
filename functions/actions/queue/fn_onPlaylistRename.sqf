/*
 * Author: Eludage
 * Renames the selected playlist to the text typed into the Manage Song Lists
 * name field.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlaylistRename;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _nameField = _display displayCtrl 16011;
if (isNull _nameField) exitWith { false };

private _selectedName = uiNamespace getVariable ["ZeusJukebox_selectedPlaylistName", ""];
if (_selectedName == "") exitWith { false };

private _newName = ctrlText _nameField;
if (_newName == "") exitWith { false };
if (_newName == _selectedName) exitWith { false };

private _playlists = uiNamespace getVariable ["ZeusJukebox_playlists", []];

private _existingNames = _playlists apply { _x select 0 };
if (_newName in _existingNames) exitWith { false };

private _idx = -1;
{
    if ((_x select 0) == _selectedName) exitWith { _idx = _forEachIndex; };
} forEach _playlists;
if (_idx == -1) exitWith { false };

private _classNames = (_playlists select _idx) select 1;
_playlists set [_idx, [_newName, _classNames]];

[_playlists] call ZeusJukebox_fnc_savePlaylists;

_nameField ctrlSetText "";
uiNamespace setVariable ["ZeusJukebox_selectedPlaylistName", _newName];

[] call ZeusJukebox_fnc_updateUiManageSongLists;

true
