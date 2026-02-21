# Zeus Jukebox Architecture

This document describes the architectural patterns and design decisions of the Zeus Jukebox mod.

## Overview

Zeus Jukebox is a client-side Arma 3 mod that allows Zeus players to manage and play music for all players on the server. The mod is designed to support multiple Zeus users simultaneously with synchronized state across all Zeus clients.

## Core Architectural Principles

### 1. Client-Side Only
- **No server-side code required** - Uses only vanilla Arma 3 functionality
- **Remote execution** - Uses `remoteExec` to coordinate actions across clients
- **Voluntary participation** - Only players with the mod see and control the system

### 2. Multi-Zeus Synchronization
- **Shared state** - Queue, currently playing track, autoplay, and looping are synchronized across all Zeus users
- **Local state** - Preview playback, favorites, and UI preferences are local to each Zeus
- **UI updates** - When any Zeus changes shared state, all Zeus UIs update automatically

### 3. Namespace Usage

#### `missionNamespace` (Shared State)
Used for state that must be synchronized across all Zeus users:
- **Currently Playing**: Track, active status, start time, paused position, duration, looping, fading
- **Queue**: Array of queued tracks `[className, displayName, duration]`
- **Autoplay**: Whether next track should play automatically
- **Zeus Registry**: List of Zeus players with dialog open

#### `uiNamespace` (Local State)
Used for state that is local to each Zeus:
- **Preview**: Track, playing status, start time, paused position, duration
- **Autoplay Preview**: Whether selecting a track immediately starts preview playback
- **Music List**: Cached track data, search state, grouping mode, expanded categories
- **Favorites**: Marked favorite tracks (synced with `profileNamespace`)
- **UI Preferences**: Font size, listen/mute state for Zeus
- **Logs**: Local log entries

#### `profileNamespace` (Persistent State)
Used for state that persists across game sessions:
- **Favorites**: Saved list of favorite tracks

## Function Architecture

### Function Categories

#### 1. Core Functions (`functions/core/`)
- **Entry Points**: Module registration, ZEN integration, dialog opening
- **Zeus Registration**: Track which Zeus users have dialog open
- **5 functions**: moduleJukebox, registerWithZen, openJukeboxDialog, registerZeus, unregisterZeus

#### 2. Action Functions (`functions/actions/*/`)
- **UI Event Handlers**: Respond to button clicks and user interactions
- **Delegate to Remote Execution**: Don't manipulate state directly
- **Pattern**: Get user input → validate → call remote execution function
- **5 subfolders**: musiclist (9 functions), options (4 functions), currentlyPlaying (8 functions), preview (7 functions), queue (8 functions)
- **36 total functions** organized by UI section

#### 3. UI Functions (`functions/ui/`)
- **UI Updates**: Read state from namespace and update controls
- **Progress Handlers**: Monitor playback progress for preview and currently playing
- **Clear Functions**: Reset UI areas and state
- **Business Logic**: Autoplay, queue management, font size
- **11 functions**: updateUiMusicList, clearPreviewArea, handlePreviewMusicProgress, updateUiPreviewArea, clearCurrentlyPlaying, handlePlayingMusicProgress, updateUiCurrentlyPlaying, updateUiQueue, getNextInQueue, checkAutoplay, changeFontSize

#### 4. Remote Execution Functions (`functions/remote/`)
- **Cross-Client Operations**: Execute code on all clients or specific Zeus clients
- **State Management**: Update `missionNamespace` state
- **Trigger Functions**: Broadcast UI updates to all registered Zeuses
- **6 functions**: remoteFadeSong, remotePauseSong, remotePlaySong, remoteRemoveSong, remoteTriggerUpdateUiCurrentlyPlaying, remoteTriggerUpdateUiQueue

#### 5. Data Functions (`functions/data/`)
- **Favorites**: Load and persist favorite tracks
- **1 function**: loadFavorites

#### 6. Utility Functions (`functions/utilities/`)
- **Helper Functions**: Formatting and configuration retrieval
- **2 functions**: formatDuration, getTrackConfig

## Data Flow Patterns

### Pattern 1: User Action → State Change → UI Update

```
1. User clicks button (e.g., Play in Queue)
   ↓
2. Action function (fn_onQueuePlay.sqf)
   - Validates input
   - Calls remote execution function
   ↓
3. Remote execution function (fn_remotePlaySong.sqf)
   - Updates missionNamespace state
   - Executes playMusic on all clients
   - Calls trigger function
   ↓
4. Trigger function (fn_remoteTriggerUpdateUiCurrentlyPlaying.sqf)
   - Loops through registered Zeuses
   - Executes UI update function on each Zeus
   ↓
5. UI update function (fn_updateUiCurrentlyPlaying.sqf) [on each Zeus]
   - Reads missionNamespace state
   - Updates UI controls
```

### Pattern 2: Preview Playback (Local Only)

```
1. User clicks Preview Play
   ↓
2. Action function (fn_onPreviewPlay.sqf)
   - Updates uiNamespace state
   - Calls playMusic locally
   - Calls local UI update function
   ↓
3. UI update function (fn_updateUiPreviewArea.sqf)
   - Reads uiNamespace state
   - Updates preview controls
```

## State Synchronization

### Shared State Updates
When shared state changes (currently playing, queue, autoplay, looping):

1. **Update missionNamespace** - One Zeus modifies shared state
2. **Remote execute code** - Code runs on all clients (e.g., `playMusic`)
3. **Trigger UI updates** - All Zeus UIs refresh from missionNamespace

### Local State Updates
When local state changes (preview, favorites, UI preferences):

1. **Update uiNamespace** - Only local Zeus modifies state
2. **Local code execution** - Code runs only locally (e.g., local `playMusic`)
3. **Local UI update** - Only local Zeus UI refreshes

## Multi-Zeus Coordination

### Zeus Registration System
- **Register on open**: `fn_registerZeus.sqf` adds Zeus to `ZeusJukebox_registeredZeuses`
- **Unregister on close**: `fn_unregisterZeus.sqf` removes Zeus from array
- **Usage**: Trigger functions use this array to target UI updates

### Preview vs Currently Playing
- **Preview**: Local playback for Zeus to audition tracks
- **Currently Playing**: Server-wide playback for all players
- **Conflict handling**: When Zeus starts preview, they automatically mute Currently Playing locally

### Queue Management
- **Shared queue**: All Zeus users see and modify the same queue
- **Race conditions**: First Zeus to act wins (e.g., playing a track removes it from queue)
- **UI updates**: All Zeus clients see queue changes immediately

## Progress Tracking

### Currently Playing Progress
```
1. remotePlaySong starts playback
   ↓
2. Spawns progress update loop (on server)
   - Runs while currentlyPlayingActive is true
   - Calls handlePlayingMusicProgress every 0.2s
   ↓
3. handlePlayingMusicProgress
   - Calculates elapsed time
   - Checks if track finished (triggers autoplay/loop)
   - Triggers UI updates for all Zeuses
   ↓
4. updateUiCurrentlyPlaying (on each Zeus)
   - Calculates progress bar position
   - Updates time display
   - Shows play/pause state
```

### Preview Progress
```
1. onPreviewPlay starts playback
   ↓
2. Spawns local progress update loop
   - Runs while previewPlaying is true
   - Calls handlePreviewMusicProgress every 0.1s
   ↓
3. handlePreviewMusicProgress
   - Calculates elapsed time
   - Checks if track finished (stops playback)
   - Calls updateUiPreviewArea
   ↓
4. updateUiPreviewArea
   - Calculates progress bar position
   - Updates time display
   - Shows play/pause state
```

## Key Design Decisions

### 1. Separation of Concerns
- **Action functions**: Handle user input only
- **Remote execution functions**: Handle state changes and coordination
- **UI update functions**: Handle display only

### 2. Single Source of Truth
- **missionNamespace**: Authoritative source for shared state
- **UI reads from namespace**: Never from dialog controls
- **State changes trigger updates**: Not the other way around

### 3. Preview Preservation
When stopping Currently Playing music, the mod preserves preview playback:
```sqf
{
    private _wasPreviewPlaying = uiNamespace getVariable ["ZeusJukebox_previewPlaying", false];
    private _previewTrack = uiNamespace getVariable ["ZeusJukebox_previewTrack", ""];
    if (_wasPreviewPlaying && _previewTrack != "") then {
        // Don't touch Zeus's preview music
    } else {
        playMusic ""; // Stop music for non-Zeus or non-previewing players
    }
} remoteExec ["call", 0, false];
```

### 4. ACE Hearing Compatibility
The fade button is automatically disabled when ACE Hearing mod is detected:
```sqf
private _aceHearingActive = (!isNil "ace_hearing_fnc_updateVolume" || 
    isClass (configFile >> "CfgPatches" >> "ace_hearing"));
if (_aceHearingActive) then {
    _btnFade ctrlEnable false;
    _btnFade ctrlSetTooltip "Disabled: ACE Hearing overrides music volume";
};
```

## Error Handling

### Validation Strategy
- **Early exits**: Functions use `exitWith` to return false on invalid input
- **Null checks**: Always check if display/controls exist before accessing
- **Empty string checks**: Validate track class names before operations

### Common Validations
```sqf
// Dialog exists
private _display = findDisplay 15000;
if (isNull _display) exitWith { false };

// Track is loaded
private _track = missionNamespace getVariable ["ZeusJukebox_currentlyPlayingTrack", ""];
if (_track == "") exitWith { false };

// Queue has items
private _queue = missionNamespace getVariable ["ZeusJukebox_queue", []];
if (count _queue == 0) exitWith { false };
```

## Performance Considerations

### Update Frequency
- **Currently Playing progress**: Updates every 0.2 seconds
- **Preview progress**: Updates every 0.1 seconds (local only)
- **UI updates**: Only when state changes, not on timer

### Remote Execution Optimization
- **Targeted updates**: Only registered Zeuses receive UI updates
- **Batch operations**: UI updates combined in trigger functions
- **Lazy evaluation**: Track info cached in `uiNamespace` HashMap

### Memory Management
- **Script handles**: Stored and terminated properly to prevent duplicates
- **Log limits**: Maximum 200 log entries (oldest removed)
- **HashMap usage**: Efficient track info lookup vs repeated config queries

## Future Considerations

### Known Limitations
1. **Client-side only**: Cannot detect music played from other sources than Zeus Jukebox. Additionally, it does not know whether players have turned their music volume down/off.
2. **ACE Hearing conflict**: Fade functionality disabled when ACE Hearing is active
3. **Race conditions**: Multiple Zeuses acting simultaneously may conflict
4. **No undo**: Actions cannot be reverted (e.g., queue removal)

## Summary

Zeus Jukebox follows a **unidirectional data flow** pattern:
- User actions trigger remote execution functions
- Remote execution functions update shared state in missionNamespace
- State changes trigger UI updates via remote execution
- UI update functions read state and update controls

This architecture ensures:
- **Consistency**: All Zeus clients see the same state
- **Maintainability**: Clear separation of responsibilities
- **Debuggability**: Predictable data flow
- **Extensibility**: Easy to add new features following established patterns
