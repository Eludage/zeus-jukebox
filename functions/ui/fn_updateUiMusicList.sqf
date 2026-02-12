/*
 * Author: Eludage
 * Populates the music list in the Jukebox dialog with all CfgMusic tracks
 * Groups tracks by their source addon with collapsible categories
 *
 * Arguments:
 * 0: Force rebuild grouped data (optional) <BOOL> default: false
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ZeusJukebox_fnc_updateUiMusicList;
 * [true] call ZeusJukebox_fnc_updateUiMusicList; // Force rebuild
 */

disableSerialization;

params [["_forceRebuild", false]];

// Color constants used in this function (runtime constants, mirror of dialog macros)
private _COLOR_HEADER = [1, 0.8, 0, 1]; // gold/yellow for category headers
private _COLOR_TRACK = [1, 1, 1, 1];     // white for track entries

// Prevent re-entry (can happen when lbClear triggers selection change)
if (uiNamespace getVariable ["ZeusJukebox_isPopulating", false]) exitWith {};
uiNamespace setVariable ["ZeusJukebox_isPopulating", true];

private _display = findDisplay 15000;
if (isNull _display) exitWith {
    uiNamespace setVariable ["ZeusJukebox_isPopulating", false];
    diag_log "[ZeusJukebox] Error: Could not find Jukebox dialog";
    systemChat "[ZeusJukebox] Error: Could not find Jukebox dialog";
};

private _listBox = _display displayCtrl 15503;
if (isNull _listBox) exitWith {
    uiNamespace setVariable ["ZeusJukebox_isPopulating", false];
    diag_log "[ZeusJukebox] Error: Could not find music listbox";
    systemChat "[ZeusJukebox] Error: Could not find music listbox";
};

// Get or initialize grouped tracks data
private _groupedTracks = uiNamespace getVariable ["ZeusJukebox_groupedTracks", createHashMap];
private _expandedCategories = uiNamespace getVariable ["ZeusJukebox_expandedCategories", createHashMap];

// Get current grouping mode
private _groupingMode = uiNamespace getVariable ["ZeusJukebox_groupingMode", "theme"];

// Build grouped tracks data if not already done or force rebuild
if (count _groupedTracks == 0 || _forceRebuild) then {
    _groupedTracks = createHashMap;

    // Get all music classes from configFile (addons/mods)
    private _cfgMusic = configFile >> "CfgMusic";
    private _musicClasses = "true" configClasses _cfgMusic;

    // Also get music classes from missionConfigFile (mission description.ext)
    private _missionCfgMusic = missionConfigFile >> "CfgMusic";
    private _missionMusicClasses = "true" configClasses _missionCfgMusic;

    diag_log format ["[ZeusJukebox] Music classes found - Addons: %1, Mission: %2", count _musicClasses, count _missionMusicClasses];

    // Combine both lists
    private _allMusicClasses = _musicClasses + _missionMusicClasses;

    // If no tracks found, show a message
    if (count _allMusicClasses == 0) exitWith {
        _listBox lbAdd "No music tracks found in CfgMusic";
        uiNamespace setVariable ["ZeusJukebox_isPopulating", false];
    };

    {
        private _config = _x;
        private _className = configName _config;

        // Check if this is from mission config
        private _isMissionMusic = isClass (missionConfigFile >> "CfgMusic" >> _className);

        private _groupName = "";
        
        if (_isMissionMusic) then {
            // Mission music always goes to "Mission Music" category
            _groupName = "Mission Music";
        } else {
            // Group by mode (addon or theme)
            if (_groupingMode == "theme") then {
                // Group by theme
                private _theme = getText (_config >> "theme");
                if (_theme == "") then {
                    _groupName = "No Theme";
                } else {
                    // Capitalize first letter of theme safely
                    private _len = count _theme;
                    private _firstChar = _theme select [0, 1];
                    private _rest = if (_len > 1) then { _theme select [1]; } else { "" };
                    _groupName = toUpper _firstChar + _rest;
                };
            } else {
                // Group by addon (default)
                private _sourceAddons = configSourceAddonList _config;
                if (count _sourceAddons > 0) then {
                    _groupName = _sourceAddons select 0;
                } else {
                    _groupName = "Unknown";
                };
            };
        };

        // Get track info
        private _displayName = getText (_config >> "name");
        private _duration = getNumber (_config >> "duration");
        private _sound = getArray (_config >> "sound");
        private _soundFile = if (count _sound > 0) then { _sound select 0 } else { "" };

        if (_displayName == "") then {
            _displayName = _className;
        };

        // Add to grouped tracks
        private _trackInfo = [_className, _displayName, _duration, _soundFile];

        if (_groupName in _groupedTracks) then {
            (_groupedTracks get _groupName) pushBack _trackInfo;
        } else {
            _groupedTracks set [_groupName, [_trackInfo]];
        };

    } forEach _allMusicClasses;

    // Store grouped tracks
    uiNamespace setVariable ["ZeusJukebox_groupedTracks", _groupedTracks];

    // Initialize all categories as collapsed by default
    if (count _expandedCategories == 0) then {
        {
            _expandedCategories set [_x, false];
        } forEach (keys _groupedTracks);
        uiNamespace setVariable ["ZeusJukebox_expandedCategories", _expandedCategories];
    };
};

// Clear existing items
lbClear _listBox;

// Get search filter text
private _searchText = "";
private _searchCtrl = _display displayCtrl 15502;
if (!isNull _searchCtrl) then {
    _searchText = toLower (ctrlText _searchCtrl);
};

// Check if favorites-only filter is active
private _favoritesOnly = uiNamespace getVariable ["ZeusJukebox_filterFavoritesOnly", false];
private _favorites = uiNamespace getVariable ["ZeusJukebox_favorites", []];

// Store track data for later use
private _trackData = [];

// Sort addon names alphabetically
private _groupNames = keys _groupedTracks;
_groupNames sort true;

// Populate listbox with grouped entries
{
    private _addonName = _x;
    private _tracks = _groupedTracks get _addonName;
    private _isExpanded = _expandedCategories getOrDefault [_addonName, false];

    // Filter tracks based on search text
    private _filteredTracks = if (_searchText == "") then {
        _tracks
    } else {
        _tracks select {
            _x params ["_className", "_displayName"];
            // Check if search text is in display name or class name (case insensitive)
            ((toLower _displayName) find _searchText) >= 0 || ((toLower _className) find _searchText) >= 0
        }
    };

    // Further filter by favorites if favorites-only is active
    if (_favoritesOnly) then {
        _filteredTracks = _filteredTracks select {
            _x params ["_className"];
            (_favorites find _className) != -1
        };
    };

    private _trackCount = count _filteredTracks;

    // Skip categories with no matching tracks when searching or filtering favorites
    if ((_searchText != "" || _favoritesOnly) && _trackCount == 0) then {
        continue;
    };

    // Add category header with expand/collapse indicator
    // When searching or filtering favorites, auto-expand categories with matches
    private _showExpanded = if (_searchText != "" || _favoritesOnly) then { true } else { _isExpanded };
    private _indicator = if (_showExpanded) then { "▼" } else { "►" };
    private _headerText = format ["%1 %2 (%3)", _indicator, _addonName, _trackCount];
    private _headerIndex = _listBox lbAdd _headerText;
    _listBox lbSetData [_headerIndex, format ["HEADER:%1", _addonName]];  // Mark as header with category name
    _listBox lbSetColor [_headerIndex, _COLOR_HEADER];  // Gold/yellow color for headers

    // Add tracks under this category only if expanded (or searching)
    if (_showExpanded) then {
        {
            _x params ["_className", "_displayName", "_duration", "_soundFile"];

            // Format duration as MM:SS
            private _durationStr = [_duration] call ZeusJukebox_fnc_formatDuration;

            // Check if this track is a favorite
            private _isFav = (_favorites find _className) != -1;
            private _favIndicator = if (_isFav) then { " *" } else { "" };

            // Create indented list entry with duration and favorite indicator
            private _listEntry = format ["     ► %1 (%2)%3", _displayName, _durationStr, _favIndicator];

            private _lbIndex = _listBox lbAdd _listEntry;
            _listBox lbSetData [_lbIndex, _className];
            _listBox lbSetColor [_lbIndex, _COLOR_TRACK];  // White color for tracks

            // Store track data
            _trackData pushBack [_className, _displayName, _duration, _soundFile];

        } forEach _filteredTracks;
    };

} forEach _groupNames;

uiNamespace setVariable ["ZeusJukebox_trackData", _trackData];

// Reset the populating flag
uiNamespace setVariable ["ZeusJukebox_isPopulating", false];
