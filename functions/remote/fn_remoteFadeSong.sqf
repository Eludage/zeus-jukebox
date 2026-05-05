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
missionNamespace setVariable ["ZeusJukebox_fadeStartTime", serverTime, true];

// Immediately sync UI to all Zeuses so the Fade button is disabled before the 5s fade completes
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiCurrentlyPlaying;

// Build fade code executed on every client
private _fadeCode = {
	private _wasPreviewPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];
	private _previewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
	if !(_wasPreviewPlaying && _previewTrack != "") then {
		5 fadeMusic 0;
	};
};

// Execute fade locally on the calling machine
[] spawn _fadeCode;

// Remote Execute fade on all other clients
_fadeCode remoteExec ["spawn", 0, false];

// After 5 seconds, restore volume, clear the track, and check autoplay
[] spawn {
	sleep 5;

	// Bail out if fading was already cancelled by a Stop/Remove
	if !(missionNamespace getVariable ["ZeusJukebox_isFading", false]) exitWith {};

	// Restore music volume to 1 on all clients BEFORE stopping the track,
	// so any autoplay next track starts at full volume
	{ 0 fadeMusic 1; } remoteExec ["call", 0, false];
	0 fadeMusic 1;

	missionNamespace setVariable ["ZeusJukebox_isFading", false, true];
	missionNamespace setVariable ["ZeusJukebox_fadeStartTime", 0, true];

	// Clear Currently Playing (also triggers autoplay check internally)
	[] call ZeusJukebox_fnc_remoteRemoveSong;
};