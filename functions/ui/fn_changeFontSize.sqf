/*
 * Author: Eludage
 * Changes the font size of ALL text elements dynamically
 *
 * Arguments:
 * 0: Direction - 1 to increase, -1 to decrease, 0 to apply current level
 *
 * Return Value:
 * None
 *
 * Example:
 * [1] call ZeusJukebox_fnc_changeFontSize;  // Increase
 * [-1] call ZeusJukebox_fnc_changeFontSize; // Decrease
 * [0] call ZeusJukebox_fnc_changeFontSize;  // Apply current saved level
 *
 * Note:
 * Maximum font size level is limited based on display aspect ratio:
 * - Ultra-wide (21:9+): Levels 0-4 (XS to XL)
 * - Standard (16:9): Levels 0-2 (XS to M) to prevent text overflow
 */

disableSerialization;

params [["_direction", 0, [0]]];

private _display = findDisplay 15000;
if (isNull _display) exitWith {};

// Get maximum font size level based on display aspect ratio (set in openJukeboxDialog)
private _maxLevel = uiNamespace getVariable ["ZeusJukebox_maxFontSizeLevel", 2];

// Get current font size level (0-4, default 2 = medium)
private _currentLevel = uiNamespace getVariable ["ZeusJukebox_fontSizeLevel", 2];

// Calculate new level
private _newLevel = (_currentLevel + _direction) max 0 min _maxLevel;

// Only update if level changed (unless direction is 0, which means force-apply current level)
if (_newLevel == _currentLevel && _direction != 0) exitWith {};

// Store new level
uiNamespace setVariable ["ZeusJukebox_fontSizeLevel", _newLevel];

// Define font sizes for each level
// List of font sizes for big buttons such as "Close"
private _listBigButtonSize = [0.040, 0.045, 0.050, 0.055, 0.060];
// List of font sizes for box titles such as "Track Info"
private _listTitleLabelSize = [0.030, 0.035, 0.040, 0.045, 0.050];
// List of font sizes for normal labels such as "Name:", "Class:", etc.
private _listNormalLabelSize = [0.020, 0.025, 0.030, 0.035, 0.040];

// Define control categories
private _listBigButtons = [15011];
private _listTitleLabels = [15101, 15102, 15103, 15104, 15105, 15106];
private _listNormalLabels = [
15201, 15202, 15203, 15204, 15205, 15206, 15207, 15208, // Track Info Labels
15301, 15305, 15306, 15307, 15308, 15309, 15310, // Preview Labels
15401, 15402, 15403, 15404, 15405, 15406, // Options Labels
15501, 15502, 15503, 15504, 15505, 15506, 15507, 15508, 15509,  // Music List
15601, 15604, 15605, 15606, 15607, 15608, 15609, 15610, 15611, 15612, 15613, // Currently Playing Labels
15701, 15702, 15703, 15704, 15705, 15706, 15707, 15708, 15709 // Queue Labels
];

// Get sizes for current level
private _bigButtonSize = _listBigButtonSize select _newLevel;
private _boxTitleSize = _listTitleLabelSize select _newLevel;
private _normalLabelSize = _listNormalLabelSize select _newLevel;

// Set guard to prevent onLBSelChanged from triggering during font change
uiNamespace setVariable ["ZeusJukebox_isPopulating", true];

// Update font sizes for all big buttons
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlSetFontHeight _bigButtonSize; _ctrl ctrlCommit 0; };
} forEach _listBigButtons;

// Update font sizes for all box titles
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlSetFontHeight _boxTitleSize; _ctrl ctrlCommit 0; };
} forEach _listTitleLabels;

// Update font sizes for all normal labels
{
    private _ctrl = _display displayCtrl _x;
    if (!isNull _ctrl) then { _ctrl ctrlSetFontHeight _normalLabelSize; _ctrl ctrlCommit 0; };
} forEach _listNormalLabels;

// Reset guard
uiNamespace setVariable ["ZeusJukebox_isPopulating", false];

// Update button states (disable at min/max)
private _btnDecrease = _display displayCtrl 15402;
private _btnIncrease = _display displayCtrl 15403;

if (!isNull _btnDecrease) then {
    _btnDecrease ctrlEnable (_newLevel > 0);
};

if (!isNull _btnIncrease) then {
    _btnIncrease ctrlEnable (_newLevel < _maxLevel);
};
