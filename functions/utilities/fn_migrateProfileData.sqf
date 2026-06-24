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
    // Add any specific transformations here.
    // For now, we just update the version.

    // Example: If we changed the format of favorites
    // private _oldFavorites = profileNamespace getVariable ["ZeusJukebox_favorites", []];
    // ... transform _oldFavorites ...
    // profileNamespace setVariable ["ZeusJukebox_favorites", _oldFavorites];

    //_storedVersion = "2.0.0";
    //profileNamespace setVariable ["ZeusJukebox_profileVersion", _storedVersion];
};

// Add more migration steps as needed
// if (_storedVersion == "2.0.0") then { ... }

true
