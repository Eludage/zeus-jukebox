/*
 * Author: Eludage
 * Populates the Manage Song Lists overlay listbox with saved playlists and
 * updates the Update/Load/Rename/Delete button enabled state based on selection.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_updateUiManageSongLists;
 */

disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _playlistsList = _display displayCtrl 16021;
if (isNull _playlistsList) exitWith { false };

private _playlists = uiNamespace getVariable ["ZeusJukebox_playlists", []];
private _previousSelected = uiNamespace getVariable ["ZeusJukebox_selectedPlaylistName", ""];

lbClear _playlistsList;

private _newSelectedIdx = -1;

{
    _x params [["_name", "", [""]], ["_classNames", [], [[]]]];

    private _text = format ["%1 (%2 tracks)", _name, count _classNames];
    private _idx = _playlistsList lbAdd _text;
    _playlistsList lbSetData [_idx, _name];

    if (_name == _previousSelected) then {
        _newSelectedIdx = _idx;
    };
} forEach _playlists;

if (_newSelectedIdx >= 0) then {
    _playlistsList lbSetCurSel _newSelectedIdx;
} else {
    uiNamespace setVariable ["ZeusJukebox_selectedPlaylistName", ""];
};

private _hasSelection = _newSelectedIdx >= 0;

private _btnUpdate = _display displayCtrl 16013;
private _btnLoad = _display displayCtrl 16022;
private _btnRename = _display displayCtrl 16023;
private _btnDelete = _display displayCtrl 16024;

if (!isNull _btnUpdate) then { _btnUpdate ctrlEnable _hasSelection; };
if (!isNull _btnLoad) then { _btnLoad ctrlEnable _hasSelection; };
if (!isNull _btnRename) then { _btnRename ctrlEnable _hasSelection; };
if (!isNull _btnDelete) then { _btnDelete ctrlEnable _hasSelection; };

true
