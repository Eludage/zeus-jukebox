/*
 * Author: Eludage
 * Handles the locally muted button click to unmute the currently playing track locally.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onPlayingLocallyMutedBtn;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Set state
uiNamespace setVariable ["ZeusJukebox_isListeningLocally", true];

// Update UI buttons
private _btnOff = _display displayCtrl 15609; // Locally muted
private _btnOn = _display displayCtrl 15610; // Locally playing
if (!isNull _btnOff) then { _btnOff ctrlShow false; };
if (!isNull _btnOn) then { _btnOn ctrlShow true; };

// Resume currently playing if any
private _currentTrack = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];
private _isActive = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingActive", false];
if (_isActive && _currentTrack != "") then {
    private _startTime = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingStartTime", 0];
    private _elapsed = serverTime - _startTime;
    playMusic [_currentTrack, _elapsed];
};

// Stop any preview that is playing
private _isPreviewPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];
if (_isPreviewPlaying) then {
    uiNamespace setVariable ["ZeusJukebox_previewPlaying", false];

    // Store the current preview position when stopping
    private _previewStartTime = uiNamespace getVariable ["ZeusJukebox_previewStartTime", 0];
    private _previewElapsed = serverTime - _previewStartTime;
    uiNamespace setVariable ["ZeusJukebox_previewPausedAt", _previewElapsed];

    // Update preview Play/Pause button
    private _btnPlay = _display displayCtrl 15306;
    private _btnPause = _display displayCtrl 15307;
    if (!isNull _btnPlay) then { _btnPlay ctrlShow true; };
    if (!isNull _btnPause) then { _btnPause ctrlShow false; };
};


true;