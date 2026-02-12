/*
 * Author: Eludage
 * Handles the export queue button click to export queue data.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onExportToQueue;
 */
disableSerialization;

private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

private _textField = _display displayCtrl 15406;
if (isNull _textField) exitWith {
	false
};

// Get queue from missionNamespace
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];

if (count _queue == 0) exitWith {
    _textField ctrlSetText "";
    false
};

// Extract class names from queue entries [className, displayName, duration]
private _classNames = _queue apply { _x select 0 };

// Convert to string array format
private _exportString = str _classNames;

// Set text field content
_textField ctrlSetText _exportString;

true;