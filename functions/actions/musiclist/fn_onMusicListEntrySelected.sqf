/*
 * Author: Eludage
 * Handles music list entry selection to display track information.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onMusicListEntrySelected;
 */
disableSerialization;

// Prevent processing during list population
if (uiNamespace getVariable ["ZeusJukebox_isPopulating", false]) exitWith { false };

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _listBox = _display displayCtrl 15503;
if (isNull _listBox) exitWith { false };

private _selectedIndex = lbCurSel _listBox;
if (_selectedIndex < 0) exitWith { false }; // No selection

// Get the data from the listbox
private _data = _listBox lbData _selectedIndex;

// Check if this is a header (data starts with "HEADER:")
if ((_data select [0, 7]) == "HEADER:") then {
    // Extract category name
    private _categoryName = _data select [7];

    // Toggle expanded state
    private _expandedCategories = uiNamespace getVariable ["ZeusJukebox_expandedCategories", createHashMap];
    private _isExpanded = _expandedCategories getOrDefault [_categoryName, false];
    _expandedCategories set [_categoryName, !_isExpanded];
    uiNamespace setVariable ["ZeusJukebox_expandedCategories", _expandedCategories];

    // Refresh the list
    [] call ZeusJukebox_fnc_updateUiMusicList;
	
} else {
    // Skip if empty data (shouldn't happen now but just in case)
    if (_data == "") exitWith {};

    // This is a track - check if it's different from current preview
    private _className = _data;
    private _currentPreviewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
    private _isPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];

    // If a different track is selected, stop current preview and load new one
    if (_currentPreviewTrack != _className) then {
        if (_isPlaying) then {
            playMusic "";
            // Stop update handle
            private _handle = uiNamespace getVariable ["ZeusJukebox_previewUpdateHandle", scriptNull];
            if (!isNull _handle) then {
                terminate _handle;
                uiNamespace setVariable ["ZeusJukebox_previewUpdateHandle", scriptNull];
            };
        };

        // Load the new song into preview by setting uiNamespace and updating UI
        uiNamespace setVariable ["ZeusJukebox_selectedMusicListTrack", _className];
        uiNamespace setVariable ["ZeusJukebox_previewTrack", _className];
        uiNamespace setVariable ["ZeusJukebox_previewPlaying", false];
        uiNamespace setVariable ["ZeusJukebox_previewStartTime", 0];
        uiNamespace setVariable ["ZeusJukebox_previewPausedAt", 0];
        
        // Get track info for preview duration
        private _trackInfo = [_className] call ZeusJukebox_fnc_getTrackConfig;
        if (_trackInfo isEqualTo []) exitWith {
            false
        };
        _trackInfo params ["", "", "_duration", ""];
        uiNamespace setVariable ["ZeusJukebox_previewDuration", _duration];
        
        // Update Track Info section
        [_className] call ZeusJukebox_fnc_updateUiTrackInfo;
        
        // Update Preview area
        [] call ZeusJukebox_fnc_updateUiPreviewArea;
    };
};