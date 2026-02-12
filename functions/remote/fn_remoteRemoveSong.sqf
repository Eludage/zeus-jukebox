/*
 * Author: Eludage
 * Remote execution function to remove the currently playing song for all clients.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_remoteRemoveSong;
 */
disableSerialization;

// remote Execute code block to stop music on each client
private _remoteCode = compile "private _wasPreviewPlaying = uiNamespace getVariable ['ZeusJukebox_previewPlaying', false]; private _previewTrack = uiNamespace getVariable ['ZeusJukebox_previewTrack', '']; if (_wasPreviewPlaying && _previewTrack != '') then {} else { playMusic ''; };";
_remoteCode remoteExec ["call", 0, false];

// Clear Currently Playing state and UI
[] call ZeusJukebox_fnc_clearCurrentlyPlaying;

// Trigger queue UI update (Play button needs updating since Currently Playing is now empty)
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

// Check if autoplay should start next track
[] call ZeusJukebox_fnc_checkAutoplay;

true