/*
 * Author: Eludage
 * Handles the Group by Music Class button click to switch grouping mode to Theme.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onMusicClassBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Toggle the grouping mode
private _currentMode = uiNamespace getVariable ["ZeusJukebox_groupingMode", "musicclass"];
private _newMode = "theme";

if (_currentMode == _newMode) exitWith { false };

uiNamespace setVariable ["ZeusJukebox_groupingMode", _newMode];

// Force rebuild and refresh the music list (updateUiMusicList handles button visibility)
[true] call ZeusJukebox_fnc_updateUiMusicList;

true
