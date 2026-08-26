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
private _COLOR_TRACK_PLAYED = [0.6, 0.6, 0.6, 1]; // dim grey for already-played tracks

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
private _groupingMode = uiNamespace getVariable ["ZeusJukebox_groupingMode", "musicclass"];

// Always update grouping button visibility to reflect current mode
private _btnAddon      = _display displayCtrl 15505;
private _btnTheme      = _display displayCtrl 15509;
private _btnMusicClass = _display displayCtrl 15510;
if (!isNull _btnAddon)      then { _btnAddon      ctrlShow (_groupingMode == "addon"); };
if (!isNull _btnTheme)      then { _btnTheme      ctrlShow (_groupingMode == "theme"); };
if (!isNull _btnMusicClass) then { _btnMusicClass ctrlShow (_groupingMode == "musicclass"); };

// Build grouped tracks data if not already done or force rebuild
if (count _groupedTracks == 0 || _forceRebuild) then {
    _groupedTracks = createHashMap;

    private _allModMusicClasses = "true" configClasses (configFile >> "CfgMusic");
    private _missionMusicClasses = "true" configClasses (missionConfigFile >> "CfgMusic");

    diag_log format ["[ZeusJukebox] Music classes found - Addons: %1, Mission: %2", count _allModMusicClasses, count _missionMusicClasses];

    // Build a set of mission class names for O(1) lookup.
    // When the same class name exists in both an addon and the mission, the mission
    // version takes precedence for playMusic, so the addon entry is suppressed to
    // avoid a misleading duplicate that would play the same (mission) audio.
    private _missionClassSet = createHashMap;
    { _missionClassSet set [configName _x, true]; } forEach _missionMusicClasses;

    private _allEntries = (
        (_allModMusicClasses select { !(_missionClassSet getOrDefault [configName _x, false]) }) apply { [_x, false] }
    ) + (_missionMusicClasses apply { [_x, true] });

    // If no tracks found, show a message
    if (count _allEntries == 0) exitWith {
        _listBox lbAdd "No music tracks found in CfgMusic";
        uiNamespace setVariable ["ZeusJukebox_isPopulating", false];
    };

    {
        _x params ["_config", "_isMissionMusic"];
        private _className = configName _config;

        // Get track info before grouping (needed for the file-existence check below)
        private _displayName = getText (_config >> "name");
        private _duration = getNumber (_config >> "duration");
        // Mission-authored tracks use a constant soundFile placeholder so favorites
        // (which persist across missions) don't break when a Zeus reuses the same
        // className across mission templates with the file in a different folder —
        // see the matching comment in fn_getTrackConfig.sqf.
        private _soundFile = if (_isMissionMusic) then {
            "mission_music"
        } else {
            private _sound = getArray (_config >> "sound");
            if (count _sound > 0) then { _sound select 0 } else { "" };
        };

        // Capture before the fallback below overwrites it, so the Hide-no-duration
        // setting can still tell these apart from tracks with a real 180s duration
        private _hasNoDuration = _duration == 0;

        if (_displayName == "") then { _displayName = _className; };
        if (_duration == 0) then { _duration = 180; };

        private _groupName = "";

        if (_isMissionMusic) then {
            _groupName = "Mission Music";
        } else {
            if (_groupingMode == "theme") then {
                private _theme = getText (_config >> "theme");
                if (_theme == "") then {
                    _groupName = "No Theme";
                } else {
                    private _len = count _theme;
                    private _firstChar = _theme select [0, 1];
                    private _rest = if (_len > 1) then { _theme select [1]; } else { "" };
                    _groupName = toUpper _firstChar + _rest;
                };
            } else {
                if (_groupingMode == "musicclass") then {
                    private _musicClassKey = getText (_config >> "musicClass");
                    if (_musicClassKey == "") then {
                        _groupName = "No Music Class";
                    } else {
                        private _musicClassDisplayName = getText (configFile >> "CfgMusicClasses" >> _musicClassKey >> "displayName");
                        if (_musicClassDisplayName == "") then {
                            _groupName = "No Music Class";
                        } else {
                            _groupName = _musicClassDisplayName;
                        };
                    };
                } else {
                    private _sourceAddons = configSourceAddonList _config;
                    if (count _sourceAddons > 0) then {
                        _groupName = _sourceAddons select 0;
                    } else {
                        _groupName = "Unknown";
                    };
                };
            };
        };

        private _trackInfo = [_className, _displayName, _duration, _soundFile, _hasNoDuration];

        if (_groupName in _groupedTracks) then {
            (_groupedTracks get _groupName) pushBack _trackInfo;
        } else {
            _groupedTracks set [_groupName, [_trackInfo]];
        };

    } forEach _allEntries;

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

// Check if hiding tracks with no duration is active
private _hideNoDuration = uiNamespace getVariable ["ZeusJukebox_hideNoDuration", false];

// Check if hiding blacklisted tracks is active
private _hideBlacklisted = uiNamespace getVariable ["ZeusJukebox_hideBlacklisted", false];
private _blacklistedEntries = getArray (configFile >> "ZeusJukebox_Blacklist" >> "entries");

// Build a lookup of already-played tracks for the played-indicator/tint below.
// Keyed on className+soundFile (not className alone) so a classname collision
// between unrelated tracks from different mods doesn't falsely mark both as played.
private _history = missionNamespace getVariable ["ZeusJukebox_trackHistory", []];
private _playedKeys = createHashMap;
{
    _x params ["_hClassName", "", "", "_hSoundFile"];
    _playedKeys set [_hClassName + "|" + _hSoundFile, true];
} forEach _history;

// Get track sort preferences (set via the Music List Settings overlay)
private _sortByTime = (uiNamespace getVariable ["ZeusJukebox_sortMode", "alphabetical"]) == "time";
private _sortAscending = (uiNamespace getVariable ["ZeusJukebox_sortDirection", "ascending"]) == "ascending";

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
            _x params ["_className", "_displayName", "_duration", "_soundFile"];
            (_favorites find (_className + "|" + _soundFile)) != -1
        };
    };

    // Further filter out tracks with no duration set in their config, if active
    if (_hideNoDuration) then {
        _filteredTracks = _filteredTracks select {
            !(_x param [4, false])
        };
    };

    // Further filter out blacklisted tracks (bad metadata from upstream mods), if active.
    // Matched on className + soundFile together so a classname collision with an
    // unrelated, correctly-tagged track from a different mod isn't hidden by mistake.
    if (_hideBlacklisted) then {
        _filteredTracks = _filteredTracks select {
            _x params ["_className", "_displayName", "_duration", "_soundFile"];
            (_blacklistedEntries find (_className + "|" + _soundFile)) == -1
        };
    };

    // Sort tracks within this category according to the stored sort preferences.
    // Pair each track with its sort key so vanilla `sort` can order them - className
    // is carried along as a deterministic tiebreak when keys are equal.
    private _sortPairs = _filteredTracks apply {
        _x params ["_className", "_displayName", "_duration"];
        [(if (_sortByTime) then { _duration } else { toLower _displayName }), _x]
    };
    _sortPairs sort _sortAscending;
    _filteredTracks = _sortPairs apply { _x select 1 };

    private _trackCount = count _filteredTracks;

    // Skip categories with no matching tracks when searching or filtering favorites
    if ((_searchText != "" || _favoritesOnly || _hideNoDuration || _hideBlacklisted) && _trackCount == 0) then {
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
            private _isFav = (_favorites find (_className + "|" + _soundFile)) != -1;
            private _favIndicator = if (_isFav) then { " *" } else { "" };

            // Check if this track has already been played
            private _isPlayed = _playedKeys getOrDefault [_className + "|" + _soundFile, false];
            private _playedIndicator = if (_isPlayed) then { " [Played]" } else { "" };

            // Create indented list entry with duration, favorite and played indicators
            private _listEntry = format ["     ► %1 (%2)%3%4", _displayName, _durationStr, _favIndicator, _playedIndicator];

            private _lbIndex = _listBox lbAdd _listEntry;
            _listBox lbSetData [_lbIndex, _className + "|" + _soundFile];
            _listBox lbSetValue [_lbIndex, _duration];
            _listBox lbSetColor [_lbIndex, if (_isPlayed) then { _COLOR_TRACK_PLAYED } else { _COLOR_TRACK }];

            // Store track data
            _trackData pushBack [_className, _displayName, _duration, _soundFile];

        } forEach _filteredTracks;
    };

} forEach _groupNames;

uiNamespace setVariable ["ZeusJukebox_trackData", _trackData];

// Reset the populating flag
uiNamespace setVariable ["ZeusJukebox_isPopulating", false];
