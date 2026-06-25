/*
 * Author: Eludage
 * Clears the track history for all Zeus clients, removing the played-track
 * highlight from the Available Music list as well.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onClearTrackHistoryBtn;
 */

disableSerialization;

missionNamespace setVariable ["ZeusJukebox_trackHistory", [], true];

// Trigger UI update for all registered Zeuses (includes the local Zeus)
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiHistory;

true
