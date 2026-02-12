/*
 * Author: Eludage
 * Opens the Zeus Jukebox dialog
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_openJukeboxDialog;
 */

disableSerialization;

// Create the dialog
private _created = createDialog "ZeusJukebox_Dialog";

if (_created) then {
	// Register this Zeus as having the dialog open
	[] call ZeusJukebox_fnc_registerZeus;
    // Small delay to ensure dialog controls are fully initialized
    [] spawn {
        disableSerialization;


        private _display = findDisplay 15000;
        if (isNull _display) exitWith {};

        // Check for ACE Hearing - disable Fade button if ACE Hearing is active
        // ACE Hearing overrides music volume, making fadeMusic ineffective
        // Check multiple indicators: function exists, or config class exists
        private _aceHearingActive = (!isNil "ace_hearing_fnc_updateVolume" ||
            isClass (configFile >> "CfgPatches" >> "ace_hearing"));
        if (_aceHearingActive) then {
            private _fadeBtn = _display displayCtrl 15607;
            if (!isNull _fadeBtn) then {
                _fadeBtn ctrlEnable false;
                _fadeBtn ctrlSetTooltip "Disabled: ACE Hearing overrides music volume";
            };
        };

        // Load favorites from profileNamespace
        private _favorites = [] call ZeusJukebox_fnc_loadFavorites;
        uiNamespace setVariable ["ZeusJukebox_favorites", _favorites];
        
        // Initialize favorites filter state (default off)
        uiNamespace setVariable ["ZeusJukebox_filterFavoritesOnly", false];

        // Initialize grouping mode (default theme)
        if (isNil {uiNamespace getVariable "ZeusJukebox_groupingMode"}) then {
            uiNamespace setVariable ["ZeusJukebox_groupingMode", "theme"];
        };

        // Update grouping button visibility based on current mode
        private _groupingMode = uiNamespace getVariable ["ZeusJukebox_groupingMode", "theme"];
        private _btnAddon = _display displayCtrl 15505;
        private _btnTheme = _display displayCtrl 15509;
        if (!isNull _btnAddon && !isNull _btnTheme) then {
            if (_groupingMode == "addon") then {
                _btnAddon ctrlShow true;
                _btnTheme ctrlShow false;
            } else {
                _btnAddon ctrlShow false;
                _btnTheme ctrlShow true;
            };
        };

        // Check if there's an existing preview track to restore
        private _existingPreviewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
        private _hasExistingPreview = _existingPreviewTrack != "";
        
        // Initialize preview state only if no existing preview
        if (!_hasExistingPreview) then {
            uiNamespace setVariable ["ZeusJukebox_previewPlaying", false];
            uiNamespace setVariable ["ZeusJukebox_previewTrack", ""];
            uiNamespace setVariable ["ZeusJukebox_previewPausedAt", 0];
            uiNamespace setVariable ["ZeusJukebox_previewStartTime", 0];
        };
        
        // Update preview UI to reflect current state
        [] call ZeusJukebox_fnc_updateUiPreviewArea;

        // Initialize Currently Playing state from missionNamespace
        if (isNil {missionNamespace getVariable "ZeusJukebox_currentlyPlayingTrack"}) then {
            missionNamespace setVariable ["ZeusJukebox_currentlyPlayingTrack", "", true];
        };
        if (isNil {missionNamespace getVariable "ZeusJukebox_currentlyPlayingActive"}) then {
            missionNamespace setVariable ["ZeusJukebox_currentlyPlayingActive", false, true];
        };
        if (isNil {missionNamespace getVariable "ZeusJukebox_currentlyPlayingStartTime"}) then {
            missionNamespace setVariable ["ZeusJukebox_currentlyPlayingStartTime", 0, true];
        };
        if (isNil {missionNamespace getVariable "ZeusJukebox_currentlyPlayingPausedAt"}) then {
            missionNamespace setVariable ["ZeusJukebox_currentlyPlayingPausedAt", 0, true];
        };
        if (isNil {missionNamespace getVariable "ZeusJukebox_looping"}) then {
            missionNamespace setVariable ["ZeusJukebox_looping", false, true];
        };

        // Initialize Queue from missionNamespace
        if (isNil {missionNamespace getVariable "ZeusJukebox_queue"}) then {
            missionNamespace setVariable ["ZeusJukebox_queue", [], true];
        };

        // Initialize Autoplay from missionNamespace
        if (isNil {missionNamespace getVariable "ZeusJukebox_autoplay"}) then {
            missionNamespace setVariable ["ZeusJukebox_autoplay", false, true];
        };

        // Initialize Listen state (default listening)
        if (isNil {uiNamespace getVariable "ZeusJukebox_isListeningLocally"}) then {
            uiNamespace setVariable ["ZeusJukebox_isListeningLocally", true];
        };

        // Detect display aspect ratio and set maximum font size level
        if (isNil {uiNamespace getVariable "ZeusJukebox_maxFontSizeLevel"}) then {
            private _resolution = getResolution;
            private _aspectRatio = _resolution select 4;
            // Ultra-wide (21:9+) can use all 5 levels (0-4)
            // Standard (16:9, 16:10) limited to 3 levels (0-2) to prevent text overflow
            private _maxLevel = if (_aspectRatio >= 2.0) then { 4 } else { 2 };
            uiNamespace setVariable ["ZeusJukebox_maxFontSizeLevel", _maxLevel];
        };

        // Update Favorites Filter button state
        private _isFavoritesFilter = uiNamespace getVariable ["ZeusJukebox_filterFavoritesOnly", false];
        private _btnFavoritesOff = _display displayCtrl 15506;
        private _btnFavoritesOn = _display displayCtrl 15507;
        if (!isNull _btnFavoritesOff) then { _btnFavoritesOff ctrlShow !_isFavoritesFilter; };
        if (!isNull _btnFavoritesOn) then { _btnFavoritesOn ctrlShow _isFavoritesFilter; };

        // Update Listen button state
        private _isListening = uiNamespace getVariable ["ZeusJukebox_isListeningLocally", true];
        private _btnListenOff = _display displayCtrl 15609;
        private _btnListenOn = _display displayCtrl 15610;
        // Show/hide according to state
        if (!isNull _btnListenOff) then { _btnListenOff ctrlShow !_isListening; };
        if (!isNull _btnListenOn) then { _btnListenOn ctrlShow _isListening; };

        // Update Currently Playing UI from missionNamespace
        [] call ZeusJukebox_fnc_updateUiCurrentlyPlaying;
        
        // Start update loop if playing
        private _isActive = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingActive", false];
        if (_isActive) then {
            [] spawn {
                disableSerialization;
                while {missionNamespace getVariable ["ZeusJukebox_currentlyPlayingActive", false]} do {
                    [] call ZeusJukebox_fnc_updateUiCurrentlyPlaying;
                    sleep 0.2;
                };
            };
        };

        // Apply saved font size to all UI elements
        [0] call ZeusJukebox_fnc_changeFontSize;

        // Ensure font size buttons are in correct state
        private _maxLevel = uiNamespace getVariable ["ZeusJukebox_maxFontSizeLevel", 2];
        private _fontLevel = uiNamespace getVariable ["ZeusJukebox_fontSizeLevel", 2];
        private _btnDecrease = _display displayCtrl 15402;
        private _btnIncrease = _display displayCtrl 15403;
        if (!isNull _btnDecrease) then {
            _btnDecrease ctrlEnable (_fontLevel > 0);
        };
        if (!isNull _btnIncrease) then {
            _btnIncrease ctrlEnable (_fontLevel < _maxLevel);
        };

        // Check if mission has changed since last populate (to reload mission-specific music)
        private _lastMissionName = uiNamespace getVariable ["ZeusJukebox_lastMissionName", ""];
        private _currentMissionName = missionName;
        private _forceRebuild = _lastMissionName != _currentMissionName;

        if (_forceRebuild) then {
            uiNamespace setVariable ["ZeusJukebox_lastMissionName", _currentMissionName];
            // Clear expanded categories so new mission music categories start collapsed
            uiNamespace setVariable ["ZeusJukebox_expandedCategories", createHashMap];
        };

        // Populate the music list (force rebuild if mission changed)
        [_forceRebuild] call ZeusJukebox_fnc_updateUiMusicList;

        // Restore preview track selection in music list if exists
        if (_hasExistingPreview) then {
            private _listBox = _display displayCtrl 15503;
            if (!isNull _listBox) then {
                private _trackToFind = _existingPreviewTrack;
                private _count = lbSize _listBox;
                private _trackFound = false;
                for "_i" from 0 to (_count - 1) do {
                    private _data = _listBox lbData _i;
                    if (_data == _trackToFind) exitWith {
                        _listBox lbSetCurSel _i;
                        _trackFound = true;
                    };
                };
                
                // Update track info display for the restored track only if the track still exists
                if (_trackFound) then {
                    [_existingPreviewTrack] call ZeusJukebox_fnc_updateUiTrackInfo;
                };
            };
        };

        // Refresh queue display
        [] call ZeusJukebox_fnc_updateUiQueue;
    };
} else {
    diag_log "[ZeusJukebox] Error: Failed to create dialog";
    systemChat "[ZeusJukebox] Error: Failed to create dialog";
};

_created
