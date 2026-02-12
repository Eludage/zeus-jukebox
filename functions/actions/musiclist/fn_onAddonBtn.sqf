/*
 * Author: Eludage
 * Handles the Group by Addon button click to switch to groupping music list by themes.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onAddonBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Toggle the grouping mode
private _currentMode = uiNamespace getVariable ["ZeusJukebox_groupingMode", "theme"];
private _newMode = "theme";

if (_currentMode == _newMode) exitWith { false };

uiNamespace setVariable ["ZeusJukebox_groupingMode", _newMode];

// Update button visibility
private _btnAddon = _display displayCtrl 15505;
private _btnTheme = _display displayCtrl 15509;
if (!isNull _btnAddon && !isNull _btnTheme) then {
    _btnAddon ctrlShow false;
    _btnTheme ctrlShow true;
};

// Force rebuild and refresh the music list
[true] call ZeusJukebox_fnc_updateUiMusicList;

true;