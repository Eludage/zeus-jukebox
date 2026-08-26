/*
 * Author: Eludage
 * Updates the Mark/Unmark Favorite button pair to reflect whether the currently selected track is a favorite.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_updateUiFavoriteMarkBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _btnMark = _display displayCtrl 15508;
private _btnUnmark = _display displayCtrl 15513;
if (isNull _btnMark || isNull _btnUnmark) exitWith { false };

private _selected = uiNamespace getVariable ["ZeusJukebox_selectedMusicListTrack", ""];
private _favorites = uiNamespace getVariable ["ZeusJukebox_favorites", []];
private _isFav = (_favorites find _selected) != -1;

_btnMark ctrlShow !_isFav;
_btnUnmark ctrlShow _isFav;

true
