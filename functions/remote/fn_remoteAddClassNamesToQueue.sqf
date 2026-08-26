/*
 * Author: Eludage
 * Validates an array of CfgMusic class names, appends the ones that resolve to
 * a real track to the shared queue, and broadcasts the update to all Zeuses.
 *
 * Arguments:
 * 0: Array of class names <ARRAY of STRING>
 *
 * Return Value:
 * Number: count of tracks actually added
 *
 * Example:
 * [["Track_01", "Track_02"]] call ZeusJukebox_fnc_remoteAddClassNamesToQueue;
 */
disableSerialization;

params [["_classNames", [], [[]]]];

if (count _classNames == 0) exitWith { 0 };

private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];

private _addedCount = 0;

{
    private _className = _x;

    if (typeName _className == "STRING") then {
        private _trackInfo = [_className] call ZeusJukebox_fnc_getTrackConfig;

        if !(_trackInfo isEqualTo []) then {
            _trackInfo params ["_config", "_displayName", "_duration", "_soundFile"];

            // soundFile from getTrackConfig may not match the intended source when the
            // same class name exists in both an addon and the mission, but import-by-class-name
            // has no way to distinguish — the engine resolves it via playMusic as usual.
            _queue pushBack [_className, _displayName, _duration, _soundFile];
            _addedCount = _addedCount + 1;
        };
    };
} forEach _classNames;

if (_addedCount > 0) then {
    missionNamespace setVariable ["ZeusJukebox_queue", _queue, true];

    // Trigger UI update for all registered Zeuses
    [] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

    // Check autoplay
    [] call ZeusJukebox_fnc_checkAutoplay;
};

_addedCount
