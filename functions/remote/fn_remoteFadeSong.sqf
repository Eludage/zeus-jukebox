/*
 * Author: Eludage
 * Remote execution function to fade out the currently playing song for all clients.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_remoteFadeSong;
 */
disableSerialization;

private _currentTrack = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];

if (_currentTrack == "") exitWith {
	false;
};

// Check if already fading
if (missionNamespace getVariable ["ZeusJukebox_isFading", false]) exitWith {
	false;
};

missionNamespace setVariable ["ZeusJukebox_isFading", true, true];

// remote Execute code block to fade music on each client
private _remoteCode = compile "private _wasPreviewPlaying = uiNamespace getVariable ['ZeusJukebox_previewPlaying', false]; private _previewTrack = uiNamespace getVariable ['ZeusJukebox_previewTrack', '']; if (_wasPreviewPlaying && _previewTrack != '') then {} else { 5 fadeMusic 0; sleep 5; 0 fadeMusic 1; playMusic ''; };";
_remoteCode remoteExec ["spawn", 0, false];

// After 5 seconds, clear the track and check autoplay
[] spawn {
    sleep 5;
    
    // Clear Currently Playing
    [] call ZeusJukebox_fnc_remoteRemoveSong;

    missionNamespace setVariable ["ZeusJukebox_isFading", false, true];

    // Check autoplay
    [] call ZeusJukebox_fnc_checkAutoplay;
};