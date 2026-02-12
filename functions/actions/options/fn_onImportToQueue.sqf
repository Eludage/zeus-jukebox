/*
 * Author: Eludage
 * Handles the import queue button click to import queue data.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onImportToQueue;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _textField = _display displayCtrl 15406;
if (isNull _textField) exitWith {
	false
};

private _inputText = ctrlText _textField;

// Check if text field is empty or contains placeholder
if (_inputText == "" || _inputText == "Array for Import/Export") exitWith {
	false
};

// Try to parse the input as an array
private _importArray = [];
private _parseError = false;

try {
    _importArray = parseSimpleArray _inputText;
} catch {
    _parseError = true;
};

// Validate that we got an array
if (_parseError || isNil "_importArray" || {typeName _importArray != "ARRAY"}) exitWith {
	false
};

if (count _importArray == 0) exitWith {
    false
};

// Get current queue
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];

// Import tracks
private _addedCount = 0;
private _skippedCount = 0;
private _skippedNames = [];

{
    private _className = _x;

    // Validate it's a string
    if (typeName _className != "STRING") then {
        _skippedCount = _skippedCount + 1;
        _skippedNames pushBack str _className;
    } else {
        // Validate the track exists using utility function
        private _trackInfo = [_className] call ZeusJukebox_fnc_getTrackConfig;

        if !(_trackInfo isEqualTo []) then {
            _trackInfo params ["_config", "_displayName", "_duration", "_soundFile"];

            // Add to queue [className, displayName, duration]
            _queue pushBack [_className, _displayName, _duration];
            _addedCount = _addedCount + 1;
        } else {
            _skippedCount = _skippedCount + 1;
            _skippedNames pushBack _className;
        };
    };
} forEach _importArray;

// Save updated queue
missionNamespace setVariable ["ZeusJukebox_queue", _queue, true];

// Trigger UI update for all registered Zeuses
[] call ZeusJukebox_fnc_remoteTriggerUpdateUiQueue;

// Clear text field after successful import
if (_addedCount > 0) then {
    _textField ctrlSetText "";
};

// Check autoplay
[] call ZeusJukebox_fnc_checkAutoplay;
true;