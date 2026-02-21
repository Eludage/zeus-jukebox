// Zeus Jukebox Dialog Definitions
// This file contains all UI/dialog class definitions

// Color macros (button and accent colors)
#define COLOR_RED {0.5, 0.2, 0.2, 1}
#define COLOR_RED_ACTIVE {0.6, 0.3, 0.3, 1}
#define COLOR_DARK_RED {0.4, 0.2, 0.2, 1}
#define COLOR_DARK_RED_ACTIVE {0.5, 0.3, 0.3, 1}
#define COLOR_GREEN {0.3, 0.5, 0.3, 1}
#define COLOR_GREEN_ACTIVE {0.4, 0.6, 0.4, 1}
#define COLOR_BLUE {0.3, 0.3, 0.5, 1}
#define COLOR_BLUE_ACTIVE {0.4, 0.4, 0.6, 1}
#define COLOR_YELLOW {1, 0.8, 0, 1}
#define COLOR_GOLDEN_BROWN {0.5, 0.4, 0.2, 1}
#define COLOR_GOLDEN_BROWN_ACTIVE {0.6, 0.5, 0.3, 1}

#define COLOR_WHITE_10 {1, 1, 1, 0.1}
#define COLOR_WHITE_100 {1, 1, 1, 1}

#define COLOR_BLACK_0 {0, 0, 0, 0}
#define COLOR_BLACK_50 {0, 0, 0, 0.5}
#define COLOR_BLACK_65 {0, 0, 0, 0.65}
#define COLOR_BLACK_100 {0, 0, 0, 1}

#define COLOR_GREY_05 {0.05, 0.05, 0.05, 1}
#define COLOR_GREY_10 {0.1, 0.1, 0.1, 1}
#define COLOR_GREY_15 {0.15, 0.15, 0.15, 1}
#define COLOR_GREY_20 {0.2, 0.2, 0.2, 1}
#define COLOR_GREY_30 {0.3, 0.3, 0.3, 1}
#define COLOR_GREY_40 {0.4, 0.4, 0.4, 1}
#define COLOR_GREY_50 {0.5, 0.5, 0.5, 1}
#define COLOR_GREY_60 {0.6, 0.6, 0.6, 1}
#define COLOR_GREY_70 {0.7, 0.7, 0.7, 1}

class ZJ_RscStatic // Base class for static elements, see https://community.bistudio.com/wiki/CT_STATIC
{
    access = 0;
    type = 0;
    idc = -1;
    // default value for safe usage
    colorBackground[] = COLOR_BLACK_0;
    colorText[] = COLOR_WHITE_100;
    text = "";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
    style = 0;
    shadow = 1;
    colorShadow[] = COLOR_BLACK_50;
    font = "RobotoCondensed";
    sizeEx = 0.04;
    linespacing = 1;
    tooltipColorText[] = COLOR_WHITE_100;
    tooltipColorBox[] = COLOR_WHITE_100;
    tooltipColorShade[] = COLOR_BLACK_65;
};

class ZJ_RscPanel: ZJ_RscStatic // Intended for background/card panels
{
    colorBackground[] = COLOR_GREY_05;
    shadow = 0;
};

class ZJ_RscBoxTitle: ZJ_RscStatic // Intended for box titles
{
    colorText[] = COLOR_YELLOW;
    font = "RobotoCondensedBold";
    sizeEx = 0.04;
    shadow = 1;
};

class ZJ_RscTextLabel: ZJ_RscStatic // Intended for normal text labels
{
    colorText[] = COLOR_WHITE_100;
    font = "RobotoCondensed";
    sizeEx = 0.03;
    shadow = 1;
};

class ZJ_RscButton // Base class for buttons, see https://community.bistudio.com/wiki/CT_BUTTON
{
    access = 0;
    type = 1;
    text = "";
    colorText[] = COLOR_WHITE_100;
    colorDisabled[] = COLOR_GREY_40;
    colorBackground[] = COLOR_BLACK_50;
    colorBackgroundDisabled[] = COLOR_BLACK_50;
    colorBackgroundActive[] = COLOR_BLACK_100;
    colorFocused[] = COLOR_BLACK_50;
    colorShadow[] = COLOR_BLACK_0;
    colorBorder[] = COLOR_BLACK_100;
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1};
    idc = -1;
    style = 2;
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    shadow = 2;
    font = "RobotoCondensed";
    sizeEx = 0.03;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    borderSize = 0;
};

class ZJ_RscListbox // Base class for listboxes, see https://community.bistudio.com/wiki/CT_LISTBOX
{
    access = 0;
    type = 5;
    style = 0;
    w = 0.4;
    h = 0.4;
    font = "RobotoCondensedLight";
    sizeEx = 0.03;
    rowHeight = 0.03;
    colorText[] = COLOR_WHITE_100;
    colorSelect[] = COLOR_BLACK_100;
    colorSelect2[] = COLOR_BLACK_100;
    colorSelectBackground[] = COLOR_GREY_30;
    colorSelectBackground2[] = COLOR_GREY_20;
    colorBackground[] = COLOR_GREY_05;
    colorDisabled[] = COLOR_GREY_40;
    maxHistoryDelay = 1.0;
    soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.09, 1};
    period = 1;
    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
    arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
    arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
    shadow = 0;
    class ListScrollBar {
        color[] = COLOR_WHITE_100;
        colorActive[] = COLOR_WHITE_100;
        colorDisabled[] = COLOR_WHITE_10;
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
};

class ZJ_RscEdit // Base class for edit fields, see https://community.bistudio.com/wiki/CT_EDIT
{
    access = 0;
    type = 2;
    style = 64;  // ST_NO_RECT
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    colorBackground[] = COLOR_GREY_15;
    colorText[] = COLOR_WHITE_100;
    colorDisabled[] = COLOR_GREY_50;
    colorSelection[] = COLOR_GREY_50;
    font = "RobotoCondensed";
    sizeEx = 0.03;
    autocomplete = "";
    text = "";
    shadow = 0;
    maxChars = 10000;
    canModify = 1;
};

class ZeusJukebox_Dialog
{
    idd = 15000;
    movingEnable = true;
    onUnload = "[] call ZeusJukebox_fnc_unregisterZeus; [] call ZeusJukebox_fnc_onPreviewPause;";
    class ControlsBackground
    {
        // Full Background
        class Background: ZJ_RscPanel
        {
            x = 0.15 * safezoneW + safezoneX;
            y = 0.1 * safezoneH + safezoneY;
            w = 0.7 * safezoneW;
            h = 0.8 * safezoneH;
            colorBackground[] = COLOR_GREY_10;
        };
        // Track Info Box - TOP ROW (left), 25% width
        class TrackInfoBackground: ZJ_RscPanel
        {
            x = 0.16 * safezoneW + safezoneX;
            y = 0.14 * safezoneH + safezoneY;
            w = 0.17 * safezoneW;
            h = 0.14 * safezoneH;
        };
        // Preview Box - TOP ROW (center), 50% width
        class PreviewBackground: ZJ_RscPanel
        {
            x = 0.34 * safezoneW + safezoneX;
            y = 0.14 * safezoneH + safezoneY;
            w = 0.34 * safezoneW;
            h = 0.14 * safezoneH;
        };
        // Options Box - TOP ROW (right), 25% width
        class OptionsBackground: ZJ_RscPanel
        {
            x = 0.69 * safezoneW + safezoneX;
            y = 0.14 * safezoneH + safezoneY;
            w = 0.15 * safezoneW;
            h = 0.14 * safezoneH;
        };
        // Available Music Box - BOTTOM ROW (left), 50% width
        class ListBackground: ZJ_RscPanel
        {
            x = 0.16 * safezoneW + safezoneX;
            y = 0.32 * safezoneH + safezoneY;
            w = 0.34 * safezoneW;
            h = 0.50 * safezoneH;
        };
        // Currently Playing Box - BOTTOM ROW (right), 50% width, top 20%
        class CurrentlyPlayingBackground: ZJ_RscPanel
        {
            x = 0.51 * safezoneW + safezoneX;
            y = 0.32 * safezoneH + safezoneY;
            w = 0.33 * safezoneW;
            h = 0.10 * safezoneH;
        };
        // Queue Box - BOTTOM ROW (right), 50% width, bottom 80%
        class QueueBackground: ZJ_RscPanel
        {
            x = 0.51 * safezoneW + safezoneX;
            y = 0.46 * safezoneH + safezoneY;
            w = 0.33 * safezoneW;
            h = 0.36 * safezoneH;
        };
    };

    class Controls
    {
        // ============== BOX Title Labels (above boxes) ==============
        // Track Info Label
        class TrackInfoLabel: ZJ_RscBoxTitle
        {
            idc = 15101;
            text = "Track Info";
            x = 0.16 * safezoneW + safezoneX;
            y = 0.11 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
        };
        // Preview Label
        class PreviewLabel: ZJ_RscBoxTitle
        {
            idc = 15102;
            text = "Preview";
            x = 0.34 * safezoneW + safezoneX;
            y = 0.11 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
        };
        // Options Label
        class OptionsLabel: ZJ_RscBoxTitle
        {
            idc = 15103;
            text = "Options";
            x = 0.69 * safezoneW + safezoneX;
            y = 0.11 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
        };
        // Available Music Label
        class MusicListLabel: ZJ_RscBoxTitle
        {
            idc = 15104;
            text = "Available Music";
            x = 0.16 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
        };
        // Currently Playing Label
        class CurrentlyPlayingLabel: ZJ_RscBoxTitle
        {
            idc = 15105;
            text = "Currently Playing";
            x = 0.51 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
        };
        // Queue Label
        class QueueLabel: ZJ_RscBoxTitle
        {
            idc = 15106;
            text = "Queue";
            x = 0.51 * safezoneW + safezoneX;
            y = 0.43 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // ============== TRACK INFO CONTENT ==============
        class TrackNameLabel: ZJ_RscTextLabel
        {
            idc = 15201;
            text = "Name:";
            x = 0.17 * safezoneW + safezoneX;
            y = 0.15 * safezoneH + safezoneY;
            w = 0.04 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = COLOR_GREY_70;
        };
        class TrackName: ZJ_RscTextLabel
        {
            idc = 15202;
            text = "-";
            x = 0.21 * safezoneW + safezoneX;
            y = 0.15 * safezoneH + safezoneY;
            w = 0.11 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class TrackClassLabel: ZJ_RscTextLabel
        {
            idc = 15203;
            text = "Class:";
            x = 0.17 * safezoneW + safezoneX;
            y = 0.18 * safezoneH + safezoneY;
            w = 0.04 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = COLOR_GREY_70;
        };
        class TrackClass: ZJ_RscTextLabel
        {
            idc = 15204;
            text = "-";
            x = 0.21 * safezoneW + safezoneX;
            y = 0.18 * safezoneH + safezoneY;
            w = 0.11 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class TrackFileLabel: ZJ_RscTextLabel
        {
            idc = 15205;
            text = "File:";
            x = 0.17 * safezoneW + safezoneX;
            y = 0.21 * safezoneH + safezoneY;
            w = 0.04 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = COLOR_GREY_70;
        };
        class TrackFile: ZJ_RscTextLabel
        {
            idc = 15206;
            text = "-";
            x = 0.21 * safezoneW + safezoneX;
            y = 0.21 * safezoneH + safezoneY;
            w = 0.11 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class TrackDurationLabel: ZJ_RscTextLabel
        {
            idc = 15207;
            text = "Duration:";
            x = 0.17 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.04 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = COLOR_GREY_70;
        };
        class TrackDuration: ZJ_RscTextLabel
        {
            idc = 15208;
            text = "-";
            x = 0.21 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.11 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // ============== PREVIEW CONTENT ==============
        // No song selected placeholder - covers entire preview box
        class PreviewNoSongText: ZJ_RscPanel
        {
            idc = 15301;
            text = "No Song selected for Preview";
            x = 0.34 * safezoneW + safezoneX;
            y = 0.14 * safezoneH + safezoneY;
            w = 0.34 * safezoneW;
            h = 0.14 * safezoneH;
            colorText[] = COLOR_GREY_60;
            colorBackground[] = COLOR_GREY_05;
            style = 2 + 512;  // ST_CENTER + ST_VCENTER (centered horizontally and vertically)
            sizeEx = 0.04;
        };
        // Preview Track Title
        class PreviewTitle: ZJ_RscTextLabel
        {
            idc = 15310;
            text = "";
            x = 0.35 * safezoneW + safezoneX;
            y = 0.15 * safezoneH + safezoneY;
            w = 0.19 * safezoneW;
            h = 0.025 * safezoneH;
        };
        // Progress bar background
        class PreviewProgressBg: ZJ_RscPanel
        {
            idc = 15302;
            x = 0.35 * safezoneW + safezoneX;
            y = 0.18 * safezoneH + safezoneY;
            w = 0.32 * safezoneW;
            h = 0.02 * safezoneH;
            colorBackground[] = COLOR_GREY_20;
        };
        // Progress bar fill
        class PreviewProgressFill: ZJ_RscPanel
        {
            idc = 15303;
            x = 0.35 * safezoneW + safezoneX;
            y = 0.18 * safezoneH + safezoneY;
            w = 0.0 * safezoneW;
            h = 0.02 * safezoneH;
            colorBackground[] = COLOR_YELLOW;
        };
        // Progress bar clickable overlay (transparent button for seeking)
        class PreviewProgressClick: ZJ_RscButton
        {
            idc = 15304;
            text = "";
            x = 0.35 * safezoneW + safezoneX;
            y = 0.18 * safezoneH + safezoneY;
            w = 0.32 * safezoneW;
            h = 0.02 * safezoneH;
            colorBackground[] = COLOR_BLACK_0;
            colorBackgroundActive[] = COLOR_WHITE_10;
            colorBackgroundDisabled[] = COLOR_BLACK_0;
            colorFocused[] = COLOR_BLACK_0;
            colorBorder[] = COLOR_BLACK_0;
            onMouseButtonUp = "[] call ZeusJukebox_fnc_onPreviewProgressBarClick;";
        };
        // Time display (elapsed / total)
        class PreviewTime: ZJ_RscTextLabel
        {
            idc = 15305;
            text = "00:00 / 00:00";
            x = 0.35 * safezoneW + safezoneX;
            y = 0.21 * safezoneH + safezoneY;
            w = 0.10 * safezoneW;
            h = 0.025 * safezoneH;
        };
        // Play button (layered with Pause button, only one visible at a time)
        class PreviewPlay: ZJ_RscButton
        {
            idc = 15306;
            text = "Play";
            x = 0.41 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.06 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPreviewPlay;";
            colorBackground[] = COLOR_GREEN;
            colorFocused[] = COLOR_GREEN;
            colorBackgroundActive[] = COLOR_GREEN_ACTIVE;
        };
        // Pause button (layered with Play button, only one visible at a time)
        class PreviewPause: ZJ_RscButton
        {
            idc = 15307;
            text = "Pause";
            x = 0.41 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.06 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPreviewPause;";
            colorBackground[] = COLOR_DARK_RED;
            colorFocused[] = COLOR_DARK_RED;
            colorBackgroundActive[] = COLOR_DARK_RED_ACTIVE;
        };
        // Remove/Clear preview button
        class PreviewRemove: ZJ_RscButton
        {
            idc = 15308;
            text = "Remove";
            x = 0.48 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.06 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPreviewRemove;";
            colorBackground[] = COLOR_RED;
            colorFocused[] = COLOR_RED;
            colorBackgroundActive[] = COLOR_RED_ACTIVE;
        };
        // Add to Queue button
        class AddToQueueButton: ZJ_RscButton
        {
            idc = 15309;
            text = "Add to Queue";
            x = 0.55 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.06 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPreviewAddToQueue;";
            colorBackground[] = COLOR_BLUE;
            colorFocused[] = COLOR_BLUE;
            colorBackgroundActive[] = COLOR_BLUE_ACTIVE;
        };
        // Autoplay Preview Label
        class AutoplayPreviewLabel: ZJ_RscTextLabel
        {
            idc = 15313;
            text = "Autoplay Preview:";
            x = 0.57 * safezoneW + safezoneX;
            y = 0.11 * safezoneH + safezoneY;
            w = 0.06 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = COLOR_GREY_70;
        };
        // Autoplay Preview OFF Button (visible when autoplay is off)
        class AutoplayPreviewOff: ZJ_RscButton
        {
            idc = 15311;
            text = "Off";
            x = 0.63 * safezoneW + safezoneX;
            y = 0.11 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onAutoplayPreviewOnBtn;";
            colorBackground[] = COLOR_DARK_RED;
            colorFocused[] = COLOR_DARK_RED;
            colorBackgroundActive[] = COLOR_DARK_RED_ACTIVE;
        };
        // Autoplay Preview ON Button (hidden initially; shown when autoplay is on)
        class AutoplayPreviewOn: ZJ_RscButton
        {
            idc = 15312;
            text = "On";
            x = 0.63 * safezoneW + safezoneX;
            y = 0.11 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onAutoplayPreviewOffBtn;";
            colorBackground[] = COLOR_GREEN;
            colorFocused[] = COLOR_GREEN;
            colorBackgroundActive[] = COLOR_GREEN_ACTIVE;
        };

        // ============== OPTIONS CONTENT ==============
        class FontSizeLabel: ZJ_RscTextLabel
        {
            idc = 15401;
            text = "Font Size";
            x = 0.7 * safezoneW + safezoneX;
            y = 0.15 * safezoneH + safezoneY;
            w = 0.04 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = COLOR_GREY_70;
        };
        class FontSizeDecrease: ZJ_RscButton
        {
            idc = 15402;
            text = "-";
            x = 0.77 * safezoneW + safezoneX;
            y = 0.15 * safezoneH + safezoneY;
            w = 0.025 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onDecreaseFontSize;";
            colorBackground[] = COLOR_GREY_30;
            colorFocused[] = COLOR_GREY_30;
            colorBackgroundActive[] = COLOR_GREY_50;
        };
        class FontSizeIncrease: ZJ_RscButton
        {
            idc = 15403;
            text = "+";
            x = 0.805 * safezoneW + safezoneX;
            y = 0.15 * safezoneH + safezoneY;
            w = 0.025 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onIncreaseFonteSize;";
            colorBackground[] = COLOR_GREY_30;
            colorFocused[] = COLOR_GREY_30;
            colorBackgroundActive[] = COLOR_GREY_50;
        };
        // ============== IMPORT/EXPORT ==============
        // Import Queue Button
        class ImportQueueBtn: ZJ_RscButton
        {
            idc = 15404;
            text = "Import to Queue";
            x = 0.70 * safezoneW + safezoneX;
            y = 0.21 * safezoneH + safezoneY;
            w = 0.06 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onImportToQueue;";
            colorBackground[] = COLOR_BLUE;
            colorFocused[] = COLOR_BLUE;
            colorBackgroundActive[] = COLOR_BLUE_ACTIVE;
        };
        // Export Queue Button
        class ExportQueueBtn: ZJ_RscButton
        {
            idc = 15405;
            text = "Export Queue";
            x = 0.77 * safezoneW + safezoneX;
            y = 0.21 * safezoneH + safezoneY;
            w = 0.06 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onExportToQueue;";
            colorBackground[] = COLOR_BLUE;
            colorFocused[] = COLOR_BLUE;
            colorBackgroundActive[] = COLOR_BLUE_ACTIVE;
        };
        // Import/Export Text Field
        class ImportExportField: ZJ_RscEdit
        {
            idc = 15406;
            x = 0.70 * safezoneW + safezoneX;
            y = 0.24 * safezoneH + safezoneY;
            w = 0.13 * safezoneW;
            h = 0.03 * safezoneH;
            maxChars = 50000;
            style = 16;
        };
        // ============== Available Music Options ==============
        // Group by label
        class MusicGroupByLabel: ZJ_RscTextLabel
        {
            idc = 15504;
            text = "Group by";
            x = 0.27 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.03 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = COLOR_GREY_70;
        };
        // Addon button
        class MusicGroupByAddonBtn: ZJ_RscButton
        {
            idc = 15505;
            text = "Addon";
            x = 0.3 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.04 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onAddonBtn;";
            tooltip = "Switch to Music Class grouping";
            colorBackground[] = COLOR_GREY_30;
            colorFocused[] = COLOR_GREY_30;
            colorBackgroundActive[] = COLOR_GREY_50;
        };
        // Theme button
        class MusicGroupByThemeBtn: ZJ_RscButton
        {
            idc = 15509;
            text = "Theme";
            x = 0.3 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.04 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onThemeBtn;";
            tooltip = "Switch to Addon grouping";
            colorBackground[] = COLOR_GREY_30;
            colorFocused[] = COLOR_GREY_30;
            colorBackgroundActive[] = COLOR_GREY_50;
        };
        // Music Class button
        class MusicGroupByMusicClassBtn: ZJ_RscButton
        {
            idc = 15510;
            text = "Music Class";
            x = 0.3 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.04 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onMusicClassBtn;";
            tooltip = "Switch to Theme grouping";
            colorBackground[] = COLOR_GREY_30;
            colorFocused[] = COLOR_GREY_30;
            colorBackgroundActive[] = COLOR_GREY_50;
        };
        // Favorite filter button
        class MusicFavoriteOff: ZJ_RscButton
        {
            idc = 15506;
            text = "*";
            x = 0.35 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.025 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onFavoriteOffBtn;";
            tooltip = "Show favorites only";
            colorBackground[] = COLOR_GREY_30;
            colorFocused[] = COLOR_GREY_30;
            colorBackgroundActive[] = COLOR_GREY_50;
        };
        // Favorite filter button
        class MusicFavoriteOn: ZJ_RscButton
        {
            idc = 15507;
            text = "*";
            x = 0.35 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.025 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onFavoriteOnBtn;";
            tooltip = "Showing favorites only (click to show all)";
            colorBackground[] = COLOR_GOLDEN_BROWN;
            colorFocused[] = COLOR_GOLDEN_BROWN;
            colorBackgroundActive[] = COLOR_GOLDEN_BROWN_ACTIVE;
        };
        // Search Label
        class MusicSearchLabel: ZJ_RscTextLabel
        {
            idc = 15501;
            text = "Search:";
            x = 0.39 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.03 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = COLOR_GREY_70;
        };
        // Search Field for Available Music
        class MusicSearchField: ZJ_RscEdit
        {
            idc = 15502;
            x = 0.42 * safezoneW + safezoneX;
            y = 0.29 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.025 * safezoneH;
            maxChars = 100;
            onKeyUp = "[] call ZeusJukebox_fnc_onSearchFieldKeyUp;";
        };

        // ============== BOTTOM ROW CONTENT ==============
        // Available Music List
        class MusicList: ZJ_RscListbox
        {
            idc = 15503;
            x = 0.16 * safezoneW + safezoneX;
            y = 0.32 * safezoneH + safezoneY;
            w = 0.34 * safezoneW;
            h = 0.50 * safezoneH;
            onLBSelChanged = "[] call ZeusJukebox_fnc_onMusicListEntrySelected;";
            onLBDblClick = "[] call ZeusJukebox_fnc_onMusicListDblClick;";
        };
        // Mark/Unmark Favorite button
        class MusicMarkFavoriteBtn: ZJ_RscButton
        {
            idc = 15508;
            text = "Mark/Unmark Favorite";
            x = 0.16 * safezoneW + safezoneX;
            y = 0.83 * safezoneH + safezoneY;
            w = 0.08 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onFavoriteMarkBtn;";
            tooltip = "Toggle favorite status for selected track";
            colorBackground[] = COLOR_GOLDEN_BROWN;
            colorFocused[] = COLOR_GOLDEN_BROWN;
            colorBackgroundActive[] = COLOR_GOLDEN_BROWN_ACTIVE;
        };
        // ============== CURRENTLY PLAYING CONTENT ==============
        // No song selected placeholder - covers entire currently playing box
        class CurrentlyPlayingNoSongText: ZJ_RscPanel
        {
            idc = 15613;
            text = "No song selected for currently playing";
            x = 0.51 * safezoneW + safezoneX;
            y = 0.32 * safezoneH + safezoneY;
            w = 0.33 * safezoneW;
            h = 0.10 * safezoneH;
            colorText[] = COLOR_GREY_60;
            colorBackground[] = COLOR_GREY_05;
            style = 2 + 512;  // ST_CENTER + ST_VCENTER (centered horizontally and vertically)
            sizeEx = 0.04;
        };
        // Currently Playing Track Title
        class CurrentlyPlayingTitle: ZJ_RscTextLabel
        {
            idc = 15601;
            text = "";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.33 * safezoneH + safezoneY;
            w = 0.19 * safezoneW;
            h = 0.025 * safezoneH;
        };
        // Currently Playing Progress Bar Background
        class CurrentlyPlayingProgressBg: ZJ_RscPanel
        {
            idc = 15602;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.36 * safezoneH + safezoneY;
            w = 0.19 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = COLOR_GREY_20;
        };
        // Currently Playing Progress Bar Fill
        class CurrentlyPlayingProgressFill: ZJ_RscPanel
        {
            idc = 15603;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.36 * safezoneH + safezoneY;
            w = 0 * safezoneW;
            h = 0.025 * safezoneH;
            colorBackground[] = COLOR_YELLOW;
        };
        // Currently Playing Time Display
        class CurrentlyPlayingTime: ZJ_RscTextLabel
        {
            idc = 15604;
            text = "";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.39 * safezoneH + safezoneY;
            w = 0.10 * safezoneW;
            h = 0.025 * safezoneH;
        };
        // Play Button (layered with Stop button, only one visible at a time)
        class CurrentlyPlayingPlay: ZJ_RscButton
        {
            idc = 15605;
            text = "Play";
            x = 0.72 * safezoneW + safezoneX;
            y = 0.33 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPlayingPlay;";
            colorBackground[] = COLOR_GREEN;
            colorFocused[] = COLOR_GREEN;
            colorBackgroundActive[] = COLOR_GREEN_ACTIVE;
        };
        // Stop Button (layered with Play button, only one visible at a time)
        class CurrentlyPlayingStop: ZJ_RscButton
        {
            idc = 15606;
            text = "Stop";
            x = 0.72 * safezoneW + safezoneX;
            y = 0.33 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPlayingPause;";
            colorBackground[] = COLOR_DARK_RED;
            colorFocused[] = COLOR_DARK_RED;
            colorBackgroundActive[] = COLOR_DARK_RED_ACTIVE;
        };
        // Fade Out Button
        class CurrentlyPlayingFadeOut: ZJ_RscButton
        {
            idc = 15607;
            text = "Fade (5s)";
            x = 0.78 * safezoneW + safezoneX;
            y = 0.33 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPlayingFade;";
            colorBackground[] = COLOR_GOLDEN_BROWN;
            colorFocused[] = COLOR_GOLDEN_BROWN;
            colorBackgroundActive[] = COLOR_GOLDEN_BROWN_ACTIVE;
        };
        // Remove Button
        class CurrentlyPlayingRemove: ZJ_RscButton
        {
            idc = 15608;
            text = "Remove";
            x = 0.72 * safezoneW + safezoneX;
            y = 0.36 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPlayingRemove;";
            colorBackground[] = COLOR_RED;
            colorFocused[] = COLOR_RED;
            colorBackgroundActive[] = COLOR_RED_ACTIVE;
        };
        // Listen Button (split into two: Locally Muted (15609) and Locally Playing (15610))
        class CurrentlyPlayingListenOff: ZJ_RscButton
        {
            idc = 15609;
            text = "Locally muted";
            x = 0.78 * safezoneW + safezoneX;
            y = 0.36 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPlayingLocallyMutedBtn;";
            colorBackground[] = COLOR_DARK_RED;
            colorFocused[] = COLOR_DARK_RED;
            colorBackgroundActive[] = COLOR_DARK_RED_ACTIVE;
        };
        class CurrentlyPlayingListenOn: ZJ_RscButton
        {
            idc = 15610;
            text = "Locally playing";
            x = 0.78 * safezoneW + safezoneX;
            y = 0.36 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPlayingLocallyUnmutedBtn;";
            colorBackground[] = COLOR_GREEN;
            colorFocused[] = COLOR_GREEN;
            colorBackgroundActive[] = COLOR_GREEN_ACTIVE;
        };
        // Loop toggle button (below Remove)
        class CurrentlyPlayingLoopOff: ZJ_RscButton
        {
            idc = 15611;
            text = "Looping off";
            x = 0.72 * safezoneW + safezoneX;
            y = 0.39 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPlayingLoopingOffBtn;";
            colorBackground[] = COLOR_BLUE;
            colorFocused[] = COLOR_BLUE;
            colorBackgroundActive[] = COLOR_BLUE_ACTIVE;
        };
        // New hidden "Looping on" button (same position/size as Looping off). Shown when looping is active.
        class CurrentlyPlayingLoopOn: ZJ_RscButton
        {
            idc = 15612;
            text = "Looping on";
            x = 0.72 * safezoneW + safezoneX;
            y = 0.39 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onPlayingLoopingOnBtn;";
            colorBackground[] = COLOR_BLUE;
            colorFocused[] = COLOR_BLUE;
            colorBackgroundActive[] = COLOR_BLUE_ACTIVE;
        };

        // ============== QUEUE SECTION ==============
        // Autoplay Label
        class AutoplayLabel: ZJ_RscTextLabel
        {
            idc = 15701;
            text = "Autoplay Global Music:";
            x = 0.72 * safezoneW + safezoneX;
            y = 0.43 * safezoneH + safezoneY;
            w = 0.07 * safezoneW;
            h = 0.025 * safezoneH;
            colorText[] = COLOR_GREY_70;
        };
        // Autoplay OFF Button (visible when autoplay is off)
        class AutoplayOff: ZJ_RscButton
        {
            idc = 15702;
            text = "Off";
            x = 0.79 * safezoneW + safezoneX;
            y = 0.43 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onQueueAutoplayOnBtn;";
            colorBackground[] = COLOR_DARK_RED;
            colorFocused[] = COLOR_DARK_RED;
            colorBackgroundActive[] = COLOR_DARK_RED_ACTIVE;
        };
        // Autoplay ON Button (hidden initially; shown when autoplay is on)
        class AutoplayOn: ZJ_RscButton
        {
            idc = 15703;
            text = "On";
            x = 0.79 * safezoneW + safezoneX;
            y = 0.43 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onQueueAutoplayOffBtn;";
            colorBackground[] = COLOR_GREEN;
            colorFocused[] = COLOR_GREEN;
            colorBackgroundActive[] = COLOR_GREEN_ACTIVE;
        };
        // Queue List
        class QueueList: ZJ_RscListbox
        {
            idc = 15704;
            x = 0.51 * safezoneW + safezoneX;
            y = 0.46 * safezoneH + safezoneY;
            w = 0.26 * safezoneW;
            h = 0.36 * safezoneH;
            onLBSelChanged = "[] call ZeusJukebox_fnc_onQueueEntrySelected;";
        };
        // Queue Play Button
        class QueuePlayBtn: ZJ_RscButton
        {
            idc = 15705;
            text = "Play";
            x = 0.78 * safezoneW + safezoneX;
            y = 0.47 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onQueuePlay;";
            colorBackground[] = COLOR_GREEN;
            colorFocused[] = COLOR_GREEN;
            colorBackgroundActive[] = COLOR_GREEN_ACTIVE;
        };
        // Queue Remove Button
        class QueueRemoveBtn: ZJ_RscButton
        {
            idc = 15706;
            text = "Remove";
            x = 0.78 * safezoneW + safezoneX;
            y = 0.50 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onQueueRemove;";
            colorBackground[] = COLOR_RED;
            colorFocused[] = COLOR_RED;
            colorBackgroundActive[] = COLOR_RED_ACTIVE;
        };
        // Queue Preview Button
        class QueuePreviewBtn: ZJ_RscButton
        {
            idc = 15707;
            text = "Preview";
            x = 0.78 * safezoneW + safezoneX;
            y = 0.53 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onQueuePreview;";
            colorBackground[] = COLOR_BLUE;
            colorFocused[] = COLOR_BLUE;
            colorBackgroundActive[] = COLOR_BLUE_ACTIVE;
        };
        // Queue Move Up Button
        class QueueMoveUpBtn: ZJ_RscButton
        {
            idc = 15708;
            text = "Up";
            x = 0.78 * safezoneW + safezoneX;
            y = 0.56 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onQueueUp;";
            colorBackground[] = COLOR_GREY_30;
            colorFocused[] = COLOR_GREY_30;
            colorBackgroundActive[] = COLOR_GREY_40;
        };
        // Queue Move Down Button
        class QueueMoveDownBtn: ZJ_RscButton
        {
            idc = 15709;
            text = "Down";
            x = 0.78 * safezoneW + safezoneX;
            y = 0.59 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.025 * safezoneH;
            action = "[] call ZeusJukebox_fnc_onQueueDown;";
            colorBackground[] = COLOR_GREY_30;
            colorFocused[] = COLOR_GREY_30;
            colorBackgroundActive[] = COLOR_GREY_40;
        };
        // ============== CLOSE BUTTON ==============
        class CloseButton: ZJ_RscButton
        {
            idc = 15011;
            text = "Close";
            x = 0.74 * safezoneW + safezoneX;
            y = 0.84 * safezoneH + safezoneY;
            w = 0.1 * safezoneW;
            h = 0.04 * safezoneH;
            action = "closeDialog 0;";
            colorBackground[] = COLOR_GREY_30;
            colorFocused[] = COLOR_GREY_30;
            colorBackgroundActive[] = COLOR_GREY_50;
            sizeEx = 0.05;
        };
    };
};
