/*
 * Function: ZeusJukebox_fnc_clearPreviewArea
 * Description: Clears the preview area and deactivates all preview controls
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ZeusJukebox_fnc_clearPreviewArea;
 */

disableSerialization;

// Stop any preview playback (but don't stop Currently Playing)
private _isPreviewPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];
if (_isPreviewPlaying) then {
    playMusic "";
};

// Stop the preview update loop if running
private _handle = uiNamespace getVariable ["ZeusJukebox_previewUpdateHandle", scriptNull];
if (!isNull _handle) then {
    terminate _handle;
    uiNamespace setVariable ["ZeusJukebox_previewUpdateHandle", scriptNull];
};

// Clear preview state variables
uiNamespace setVariable ["ZeusJukebox_previewTrack", ""];
uiNamespace setVariable ["ZeusJukebox_previewDuration", 0];
uiNamespace setVariable ["ZeusJukebox_previewStartTime", 0];
uiNamespace setVariable ["ZeusJukebox_previewPausedAt", 0];
uiNamespace setVariable ["ZeusJukebox_previewPlaying", false];
uiNamespace setVariable ["ZeusJukebox_selectedMusicListTrack", ""];

// Clear track info display
[""] call ZeusJukebox_fnc_updateUiTrackInfo;

[] call ZeusJukebox_fnc_updateUiPreviewArea;