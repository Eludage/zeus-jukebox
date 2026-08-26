/*
 * Author: Eludage
 * Saves the current queue as a new named playlist using the text typed into
 * the Manage Song Lists name field.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlaylistSaveNew;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _nameField = _display displayCtrl 16011;
if (isNull _nameField) exitWith { false };

private _name = ctrlText _nameField;
if (_name == "") exitWith { false };

private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
if (count _queue == 0) exitWith { false };

private _playlists = uiNamespace getVariable ["ZeusJukebox_playlists", []];

// Reject duplicate names - use Update Selected instead
private _existingNames = _playlists apply { _x select 0 };
if (_name in _existingNames) exitWith { false };

private _classNames = _queue apply { _x select 0 };
_playlists pushBack [_name, _classNames];

[_playlists] call ZeusJukebox_fnc_savePlaylists;

_nameField ctrlSetText "";

[] call ZeusJukebox_fnc_updateUiManageSongLists;

true
