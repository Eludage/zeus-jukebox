/*
 * Author: Eludage
 * Handles the "Autoplay Preview Off" button click to enable autoplay preview.
 * When autoplay preview is on, any song loaded into the preview area will
 * immediately start playing, and the currently playing track will be locally
 * muted if needed.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onAutoplayPreviewOnBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Enable autoplay preview
uiNamespace setVariable ["ZeusJukebox_autoplayPreview", true];

// If a track is already loaded in preview but not yet playing, start it now
private _previewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
private _isPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];
if (_previewTrack != "" && !_isPlaying) then {
	[] call ZeusJukebox_fnc_onPreviewPlay;
} else {
	[] call ZeusJukebox_fnc_updateUiPreviewArea;
};

true
