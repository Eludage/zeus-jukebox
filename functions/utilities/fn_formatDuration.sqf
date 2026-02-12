/*
 * Author: Eludage
 * Formats a duration in seconds to MM:SS format
 *
 * Arguments:
 * 0: Duration in seconds <NUMBER>
 *
 * Return Value:
 * Formatted string "MM:SS" <STRING>
 *
 * Example:
 * [125] call ZeusJukebox_fnc_formatDuration; // Returns "02:05"
 */

params [["_seconds", 0, [0]]];

private _minutes = floor (_seconds / 60);
private _secs = floor (_seconds mod 60);

format ["%1:%2",
    if (_minutes < 10) then { format ["0%1", _minutes] } else { str _minutes },
    if (_secs < 10) then { format ["0%1", _secs] } else { str _secs }
]
