/*
 * Author: Eludage
 * Migrates profileNamespace variables to the latest version format.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_migrateProfileData;
 */

private _currentVersion = [] call ZeusJukebox_fnc_getModVersion;
private _storedVersion = profileNamespace getVariable ["ZeusJukebox_profileVersion", "1.0.0"];

if (_storedVersion == _currentVersion) exitWith { true };

// --- Migration Logic ---

// Migration from 1.0.0 to 2.0.0
if (_storedVersion == "1.0.0") then {
    // 2.0.0 changed ZeusJukebox_favorites from plain className strings to a
    // composite "className|soundFile" key (see fn_getTrackConfig.sqf /
    // fn_updateUiMusicList.sqf) to stop favoriting one track from also
    // favoriting every other CfgMusic entry that happens to share its className.
    //
    // Ambiguity note: if a className exists in BOTH the mission and an addon's
    // CfgMusic at the moment this runs, getTrackConfig resolves the mission
    // entry first (matching playMusic's own resolution order) - there is no way
    // to recover which one old, classname-only data actually meant. Unavoidable,
    // accepted one-time ambiguity for pre-existing favorites.
    private _oldFavorites = profileNamespace getVariable ["ZeusJukebox_favorites", []];
    private _newFavorites = [];

    {
        private _trackInfo = [_x] call ZeusJukebox_fnc_getTrackConfig;
        if !(_trackInfo isEqualTo []) then {
            _trackInfo params ["", "", "", "_soundFile"];
            _newFavorites pushBackUnique (_x + "|" + _soundFile);
        };
        // else: track no longer resolves in any config - drop the favorite.
    } forEach _oldFavorites;

    profileNamespace setVariable ["ZeusJukebox_favorites", _newFavorites];

    _storedVersion = "2.0.0";
    profileNamespace setVariable ["ZeusJukebox_profileVersion", _storedVersion];
    saveProfileNamespace;
};

// Add more migration steps as needed
// if (_storedVersion == "2.0.0") then { ... }

true
