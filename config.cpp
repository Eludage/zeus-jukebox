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
            class onSearchFieldKeyUp {};         // Search field key up
            class onAddonBtn {};                 // Group by Addon button
            class onThemeBtn {};                 // Group by Theme button
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
        };

        // ===== UI Updates & Management =====
        class ui
        {
            file = "ZeusJukebox\functions\ui";
            class updateUiMusicList {};          // Updates music list UI
            class updateUiTrackInfo {};          // Updates Track Info section
            class clearPreviewArea {};           // Clear the preview area
            class handlePreviewMusicProgress {}; // Handle preview track progress
            class updateUiPreviewArea {};        // Updates preview UI
            class clearCurrentlyPlaying {};      // Clear Currently Playing UI/state
            class handlePlayingMusicProgress {}; // Handle track progress and autoplay/loop
            class updateUiCurrentlyPlaying {};   // Updates currently playing UI
            class updateUiQueue {};              // Updates queue UI
            class getNextInQueue {};             // Get and remove next track from queue
            class checkAutoplay {};              // Check if autoplay should trigger
            class changeFontSize {};             // Adjust UI font size
        };

        // ===== Utilities =====
        class utilities
        {
            file = "ZeusJukebox\functions\utilities";
            class formatDuration {};             // Format seconds to MM:SS
            class getTrackConfig {};             // Get track info from CfgMusic
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
