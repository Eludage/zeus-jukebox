/*
 * Author: Eludage
 * Handles the locally playing button click to mute the currently playing track locally.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlayingLocallyUnmutedBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Set state
uiNamespace setVariable ["ZeusJukebox_isListeningLocally", false];

// Stop local music playback
playMusic "";

// Update UI buttons
private _btnOff = _display displayCtrl 15609; // Locally muted
private _btnOn = _display displayCtrl 15610; // Locally playing
if (!isNull _btnOff) then { _btnOff ctrlShow true; };
if (!isNull _btnOn) then { _btnOn ctrlShow false; };


true;