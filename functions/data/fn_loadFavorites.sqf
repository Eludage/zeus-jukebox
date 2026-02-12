/*
 * Author: Eludage
 * Loads the favorites list from profileNamespace
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Array - Array of favorite track classnames
 *
 * Example:
 * [] call ZeusJukebox_fnc_loadFavorites;
 */

private _favorites = profileNamespace getVariable ["ZeusJukebox_favorites", []];
_favorites
