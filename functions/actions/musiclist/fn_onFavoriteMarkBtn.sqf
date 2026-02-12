/*
 * Author: Eludage
 * Handles the Mark/Unmark Favorite button click in the music list.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onFavoriteMarkBtn;
 */

disableSerialization;
private _musicTrack = uiNamespace getVariable ["ZeusJukebox_selectedMusicListTrack", ""];
if (_musicTrack == "") exitWith { false };

private _favorites = uiNamespace getVariable ["ZeusJukebox_favorites", []];

private _idx = _favorites find _musicTrack;
// Check if already a favorite
if (_idx != -1) then {
    // Unmark as favorite
    _favorites deleteAt _idx;
} else {
    // Mark as favorite
    _favorites pushBack _musicTrack;
};

uiNamespace setVariable ["ZeusJukebox_favorites", _favorites];
profileNamespace setVariable ["ZeusJukebox_favorites", _favorites];
saveProfileNamespace;

// Refresh the music list
[] call ZeusJukebox_fnc_updateUiMusicList;

true;