/*
 * Author: Eludage
 * Handles playlist entry selection to update Manage Song Lists button state.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlaylistEntrySelected;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _playlistsList = _display displayCtrl 16021;
if (isNull _playlistsList) exitWith { false };

// Capture current selection before updateUiManageSongLists clears and rebuilds
private _curSel = lbCurSel _playlistsList;
private _selectedName = "";

if (_curSel >= 0) then {
    _selectedName = _playlistsList lbData _curSel;
};

uiNamespace setVariable ["ZeusJukebox_selectedPlaylistName", _selectedName];

[] call ZeusJukebox_fnc_updateUiManageSongLists;

true
