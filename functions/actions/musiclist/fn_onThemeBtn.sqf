/*
 * Author: Eludage
 * Handles the Group by Theme button click to switch to groupping music list by addons.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onThemeBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Toggle the grouping mode
private _currentMode = uiNamespace getVariable ["ZeusJukebox_groupingMode", "theme"];
private _newMode = "addon";

if (_currentMode == _newMode) exitWith { false };

uiNamespace setVariable ["ZeusJukebox_groupingMode", _newMode];

// Update button visibility
private _btnAddon = _display displayCtrl 15505;
private _btnTheme = _display displayCtrl 15509;
if (!isNull _btnAddon && !isNull _btnTheme) then {
    _btnAddon ctrlShow true;
    _btnTheme ctrlShow false;
};

// Force rebuild and refresh the music list
[true] call ZeusJukebox_fnc_updateUiMusicList;

true;