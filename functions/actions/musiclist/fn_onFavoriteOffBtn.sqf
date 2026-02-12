/*
 * Author: Eludage
 * Handles the Favorites filter OFF button click to turn on favorite filtering.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onFavoriteOffBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Toggle the filter state
private _currentState = uiNamespace getVariable ["ZeusJukebox_filterFavoritesOnly", false];
private _newState = true; // We are turning the filter ON to show only favorites

if (_currentState == _newState) exitWith { false }; // No change needed

uiNamespace setVariable ["ZeusJukebox_filterFavoritesOnly", _newState];

// Update button appearance
private _favOffBtn = _display displayCtrl 15506;
private _favOnBtn = _display displayCtrl 15507;

if (!isNull _favOffBtn && !isNull _favOnBtn) then {
    _favOffBtn ctrlShow false;
    _favOnBtn ctrlShow true;
};

// Refresh the music list
[] call ZeusJukebox_fnc_updateUiMusicList;

true;