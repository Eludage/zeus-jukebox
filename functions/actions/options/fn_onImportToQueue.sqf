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

// Validate, append to queue, and broadcast in one shared step (also used by
// Manage Song Lists' "Load to Queue" button)
private _addedCount = [_importArray] call ZeusJukebox_fnc_remoteAddClassNamesToQueue;

// Clear text field after successful import
if (_addedCount > 0) then {
    _textField ctrlSetText "";
};

true;