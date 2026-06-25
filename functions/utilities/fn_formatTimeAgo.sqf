/*
 * Author: Eludage
 * Formats elapsed time since a serverTime timestamp into a relative "time ago" string.
 *
 * Arguments:
 * 0: serverTime timestamp to compare against the current serverTime <NUMBER>
 *
 * Return Value:
 * String: e.g. "just now", "5 min ago", "1 hour ago", "2 days ago"
 *
 * Example:
 * [_playedAt] call ZeusJukebox_fnc_formatTimeAgo;
 */

params [["_playedAt", 0, [0]]];

private _elapsed = 0 max (serverTime - _playedAt);

if (_elapsed < 60) exitWith { "just now" };

if (_elapsed < 3600) then {
	private _minutes = floor (_elapsed / 60);
	format ["%1 min%2 ago", _minutes, if (_minutes == 1) then { "" } else { "s" }]
} else {
	if (_elapsed < 86400) then {
		private _hours = floor (_elapsed / 3600);
		format ["%1 hour%2 ago", _hours, if (_hours == 1) then { "" } else { "s" }]
	} else {
		private _days = floor (_elapsed / 86400);
		format ["%1 day%2 ago", _days, if (_days == 1) then { "" } else { "s" }]
	};
};
