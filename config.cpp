class CfgPatches
{
    class ZeusJukebox
    {
        name = "Zeus Jukebox";
        author = "Eludage";
        url = "";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {
            "A3_Modules_F_Curator",
            "A3_UI_F",
            "zen_main"
        };
    };
};

class CfgFunctions
{
    class ZeusJukebox
    {

        // ===== UI Actions - Music List =====
        class actions_musiclist
        {
            file = "ZeusJukebox\functions\actions\musiclist";
            class onFavoriteMarkBtn {};          // Mark/Unmark favorite button
            class onFavoriteOffBtn {};           // Favorites filter OFF button
            class onFavoriteOnBtn {};            // Favorites filter ON button
            class onMusicListEntrySelected {};   // Music list entry selected
            class onMusicListDblClick {};        // Music list double-click (add to queue)
            class onSearchFieldKeyUp {};         // Search field key up
            class onAddonBtn {};                 // Group by Addon button
            class onThemeBtn {};                 // Group by Theme button
            class onMusicClassBtn {};            // Group by Music Class button
            class onMusicListSettings {};        // Music List Settings button
            class onMusicListSettingsClose {};   // Music List Settings overlay close (X) button
        };

        // ===== UI Actions - Track History =====
        class actions_history
        {
            file = "ZeusJukebox\functions\actions\history";
            class onTrackHistoryOpen {};         // Track History button (open overlay)
            class onTrackHistoryClose {};        // Track History overlay close (X) button
            class onClearTrackHistoryBtn {};     // Clear History button
            class onTrackHistoryDblClick {};     // Double-click a history entry to re-add it to the queue
        };

        // ===== UI Actions - Music List Settings =====
        class actions_musiclistSettings
        {
            file = "ZeusJukebox\functions\actions\musiclistSettings";
            class onSettingsSortAlphabeticalBtn {}; // Settings: switch sort to by Time
            class onSettingsSortByTimeBtn {};       // Settings: switch sort to Alphabetical
            class onSettingsSortAscendingBtn {};    // Settings: switch sort direction to Descending
            class onSettingsSortDescendingBtn {};   // Settings: switch sort direction to Ascending
            class onSettingsHideNoDurationYesBtn {}; // Settings: stop hiding music with no duration
            class onSettingsHideNoDurationNoBtn {};  // Settings: start hiding music with no duration
            class onSettingsHideBlacklistedYesBtn {}; // Settings: stop hiding blacklisted music
            class onSettingsHideBlacklistedNoBtn {};  // Settings: start hiding blacklisted music
        };

        // ===== UI Actions - Options =====
        class actions_options
        {
            file = "ZeusJukebox\functions\actions\options";
            class onDecreaseFontSize {};         // Decrease font size button
            class onIncreaseFonteSize {};        // Increase font size button
            class onImportToQueue {};            // Import queue button
            class onExportToQueue {};            // Export queue button
        };

        // ===== UI Actions - Currently Playing =====
        class actions_currentlyPlaying
        {
            file = "ZeusJukebox\functions\actions\currentlyPlaying";
            class onPlayingFade {};              // Fade out button
            class onPlayingLocallyMutedBtn {};   // Locally muted button
            class onPlayingLocallyUnmutedBtn {}; // Locally playing button
            class onPlayingLoopingOffBtn {};     // Looping off button
            class onPlayingLoopingOnBtn {};      // Looping on button
            class onPlayingPause {};             // Pause button
            class onPlayingPlay {};              // Play button
            class onPlayingRemove {};            // Remove button
        };

        // ===== UI Actions - Preview =====
        class actions_preview
        {
            file = "ZeusJukebox\functions\actions\preview";
            class onPreviewAddToQueue {};        // Add to queue button
            class onPreviewPause {};             // Preview pause button
            class onPreviewPlay {};              // Preview play button
            class onPreviewProgressBarClick {};  // Preview progress bar click
            class onPreviewRemove {};            // Preview remove button
            class onAutoplayPreviewOnBtn {};     // Enable autoplay preview
            class onAutoplayPreviewOffBtn {};    // Disable autoplay preview
        };

        // ===== UI Actions - Queue =====
        class actions_queue
        {
            file = "ZeusJukebox\functions\actions\queue";
            class onQueueAutoplayOffBtn {};      // Autoplay off button
            class onQueueAutoplayOnBtn {};       // Autoplay on button
            class onQueueDown {};                // Move down button
            class onQueueEntrySelected {};       // Queue entry selected
            class onQueuePlay {};                // Queue play button
            class onQueuePreview {};             // Queue preview button
            class onQueueRemove {};              // Queue remove button
            class onQueueUp {};                  // Move up button
            class onManageSongList {};           // Manage Song List button (opens Manage Song Lists overlay)
            class onManageSongListClose {};      // Manage Song Lists overlay close (X) button
            class onPlaylistSaveNew {};          // Save current queue as a new playlist
            class onPlaylistUpdateSelected {};   // Overwrite selected playlist with current queue
            class onPlaylistLoad {};             // Load selected playlist into queue
            class onPlaylistRename {};           // Rename selected playlist
            class onPlaylistDelete {};           // Delete selected playlist
            class onPlaylistEntrySelected {};    // Playlist entry selected
        };

        // ===== Core / Initialization =====
        class core
        {
            file = "ZeusJukebox\functions\core";
            class moduleJukebox {};              // Module entry point
            class registerWithZen { postInit = 1; };  // ZEN integration
            class openJukeboxDialog {};          // Opens the main dialog
            class registerZeus {};               // Register Zeus when opening dialog
            class unregisterZeus {};             // Unregister Zeus when closing dialog
        };

        // ===== Data Management (Favorites) =====
        class data
        {
            file = "ZeusJukebox\functions\data";
            class loadFavorites {};              // Load favorites from profileNamespace
            class loadPlaylists {};              // Load saved playlists from profileNamespace
            class savePlaylists {};              // Persist saved playlists to profileNamespace
        };

        // ===== Remote Executions =====
        class remote
        {
            file = "ZeusJukebox\functions\remote";
            class remoteFadeSong {};                   // Fade out song for all clients
            class remotePauseSong {};                  // Pause song for all clients
            class remotePlaySong {};                   // Play song for all clients
            class remoteRemoveSong {};                 // Remove song for all clients
            class remoteTriggerUpdateUiCurrentlyPlaying {}; // Trigger UI update for currently playing
            class remoteTriggerUpdateUiQueue {};       // Trigger UI update for queue
            class remoteTriggerUpdateUiHistory {};     // Trigger UI update for track history + played highlight
            class remoteAddClassNamesToQueue {};       // Validate class names and append them to the queue for all Zeuses
        };

        // ===== UI Updates & Management =====
        class ui
        {
            file = "ZeusJukebox\functions\ui";
            class updateUiMusicList {};          // Updates music list UI
            class updateUiTrackInfo {};          // Updates Track Info section
            class updateUiFavoriteMarkBtn {};    // Updates Mark/Unmark Favorite button to match selected track
            class clearPreviewArea {};           // Clear the preview area
            class handlePreviewMusicProgress {}; // Handle preview track progress
            class updateUiPreviewArea {};        // Updates preview UI
            class clearCurrentlyPlaying {};      // Clear Currently Playing UI/state
            class handlePlayingMusicProgress {}; // Handle track progress and autoplay/loop
            class updateUiCurrentlyPlaying {};   // Updates currently playing UI
            class updateUiQueue {};              // Updates queue UI
            class updateUiHistory {};            // Updates track history overlay UI
            class updateUiManageSongLists {};    // Updates Manage Song Lists overlay UI
            class getNextInQueue {};             // Get and remove next track from queue
            class checkAutoplay {};              // Check if autoplay should trigger
            class changeFontSize {};             // Adjust UI font size
        };

        // ===== Utilities =====
        class utilities
        {
            file = "ZeusJukebox\functions\utilities";
            class formatDuration {};             // Format seconds to MM:SS
            class formatTimeAgo {};              // Format elapsed serverTime into a relative "time ago" string
            class getTrackConfig {};             // Get track info from CfgMusic
            class getModVersion {};              // Get current mod version string
            class migrateProfileData {};         // Migrate profileNamespace data to latest version
        };
    };
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class ZeusJukebox_Modules: NO_CATEGORY
    {
        displayName = "Zeus Jukebox";
    };
};

class CfgVehicles
{
    class Logic;
    class Module_F: Logic
    {
        class ArgumentsBaseUnits {};
        class ModuleDescription {};
    };
    class ZeusJukebox_ModuleBase: Module_F
    {
        scope = 1;
        scopeCurator = 1;
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 0;
        isDisposable = 0;
        is3DEN = 0;
        class AttributesBase
        {
            class Default;
            class Edit;
            class Combo;
            class Checkbox;
            class CheckboxNumber;
            class ModuleDescription;
            class Units;
        };
    };
    class ZeusJukebox_Module: ZeusJukebox_ModuleBase
    {
        scope = 0;
        scopeCurator = 0;
        displayName = "Jukebox";
        icon = "";
        category = "ZeusJukebox_Modules";
        function = "ZeusJukebox_fnc_moduleJukebox";
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 0;
        isDisposable = 0;
        class ModuleDescription
        {
            description = "Opens the Zeus Jukebox interface for music management.";
            sync[] = {};
        };
    };
};

// Include dialog definitions from external file
#include "dialogs.hpp"

// Include blacklisted track classname+soundFile entries from external file
#include "blacklist.hpp"
