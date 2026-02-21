# Development Help

This document contains helpful development-oriented references for working on ZeusJukebox. It contains the control ID reference.

## Dialog and Control ID Reference

This section lists the main dialog ID (IDD) and the control IDCs used in the Jukebox dialog (`dialogs.hpp`). Use these IDs in scripts to access controls via `findDisplay` and `displayCtrl`.

- Dialog IDs:
  - Zeus Jukebox main dialog idd: 15000

- Controls (idc → control name — brief purpose):
  - Box labels
    - 15101 → TrackInfoLabel — section title "Track Info"
    - 15102 → PreviewLabel — section title "Preview"
    - 15103 → OptionsLabel — section title "Options"
    - 15104 → MusicListLabel — section title "Available Music"
    - 15105 → CurrentlyPlayingLabel — section title "Currently Playing"
    - 15106 → QueueLabel — section title "Queue"
  - Track info controls
    - 15201 → TrackNameLabel — label "Name:"
    - 15202 → TrackName — track display name (value)
    - 15203 → TrackClassLabel — label "Class:"
    - 15204 → TrackClass — class name display (value)
    - 15205 → TrackFileLabel — label "File:"
    - 15206 → TrackFile — file path display (value)
    - 15207 → TrackDurationLabel — label "Duration:"
    - 15208 → TrackDuration — duration display (value)
  - Preview controls
    - 15301 → PreviewNoSongText — placeholder text shown when no preview is loaded
    - 15310 → PreviewTitle — Preview track title
    - 15302 → PreviewProgressBg — preview progress bar background
    - 15303 → PreviewProgressFill — preview progress bar fill
    - 15304 → PreviewProgressClick — transparent overlay used to seek in preview
    - 15305 → PreviewTime — preview elapsed/total time text
    - 15306 → PreviewPlay — Play button (preview)
    - 15307 → PreviewPause — Pause button (preview)
    - 15308 → PreviewRemove — Remove / clear preview
    - 15309 → AddToQueueButton — Add current preview to Queue
    - 15311 → AutoplayPreviewOff — Autoplay Preview OFF button (visible when autoplay preview is off)
    - 15312 → AutoplayPreviewOn — Autoplay Preview ON button (visible when autoplay preview is on)
    - 15313 → AutoplayPreviewLabel — label "Autoplay Preview:"
  - Options controls
    - 15401 → FontSizeLabel — label "Font Size"
    - 15402 → FontSizeDecrease — font size decrease button
    - 15403 → FontSizeIncrease — font size increase button
    - 15404 → ImportQueueBtn — Import queue button
    - 15405 → ExportQueueBtn — Export queue button
    - 15406 → ImportExportField — Edit field for import/export text
  - Music list controls
    - 15501 → MusicSearchLabel — label "Search:"
    - 15502 → MusicSearchField — search edit field for Available Music
    - 15503 → MusicList — the Available Music listbox (single-click selects/loads preview; double-click adds to queue)
    - 15504 → MusicGroupByLabel — label "Group by:"
    - 15505 → MusicGroupByAddonBtn — Toggles to grouping by Theme
    - 15506 → MusicFavoriteBtn — label "*"
    - 15508 → MusicMarkFavoriteBtn — Mark/Unmark Favorite
    - 15509 → MusicGroupByThemeBtn — Toggles to grouping by Addon
  - Currently playing controls
    - 15601 → CurrentlyPlayingTitle — currently playing track title
    - 15602 → CurrentlyPlayingProgressBg — currently playing progress background
    - 15603 → CurrentlyPlayingProgressFill — currently playing progress fill
    - 15604 → CurrentlyPlayingTime — currently playing time text
    - 15605 → CurrentlyPlayingPlay — play for currently playing (server-wide)
    - 15606 → CurrentlyPlayingStop — stop for currently playing (server-wide)
    - 15607 → CurrentlyPlayingFadeOut — fade out button
    - 15608 → CurrentlyPlayingRemove — remove currently playing track
    - 15609 → CurrentlyPlayingListenOff — "Locally muted" button (visible when Zeus is muted locally)
    - 15610 → CurrentlyPlayingListenOn — "Locally playing" button (visible when Zeus is listening locally)
    - 15611 → CurrentlyPlayingLoopOff — looping off button (visible when looping is disabled)
    - 15612 → CurrentlyPlayingLoopOn — looping on button (visible when looping is enabled)
  - Queue controls
    - 15701 → AutoplayLabel — label "Autoplay"
    - 15702 → AutoplayOff — Autoplay OFF button (visible when autoplay is off)
    - 15703 → AutoplayOn — Autoplay ON button (visible when autoplay is on)
    - 15704 → QueueList — the Queue listbox
    - 15705 → QueuePlayBtn — Play selected queue item
    - 15706 → QueueRemoveBtn — Remove queue item
    - 15707 → QueuePreviewBtn — Preview queue item
    - 15708 → QueueMoveUpBtn — Move queue item up
    - 15709 → QueueMoveDownBtn — Move queue item down
  - Misc controls
    - 15011   → CloseButton — Close dialog button

Notes
- Access controls in scripts like this:
  - `_disp = findDisplay 15000; _ctrl = _disp displayCtrl 15503;` (gets the Available Music listbox)
  - Then operate on the control: `_ctrl lbAdd "My Track";` or `_ctrl ctrlSetText "...";`
- Only controls with idc >= 0 can be accessed via `displayCtrl`.

## Namespaces and variables used
This section documents the runtime namespaces and variables used by Zeus Jukebox.

### Namespace `missionNamespace`

#### Currently Playing State
- `ZeusJukebox_currentlyPlayingTrack`: String — Class name of the currently playing track (server-wide playback). Empty string when nothing is playing.
- `ZeusJukebox_currentlyPlayingActive`: Boolean — Whether a track is actively playing.
- `ZeusJukebox_currentlyPlayingStartTime`: Number — Game time (in seconds from mission start) when the track started.
- `ZeusJukebox_currentlyPlayingPausedAt`: Number — Time position (in seconds) where the track was paused. Used for resume functionality.
- `ZeusJukebox_currentlyPlayingDuration`: Number — Duration of the currently playing track in seconds.
- `ZeusJukebox_currentlyPlayingUpdateHandle`: Script Handle — Handle to the currently playing progress update loop. Stored to prevent spawning duplicate loops.
- `ZeusJukebox_looping`: Boolean — Whether the currently playing track should loop when it finishes.
- `ZeusJukebox_isFading`: Boolean — Whether the currently playing track is currently fading out.

#### Queue Management
- `ZeusJukebox_queue`: Array — Array of track info arrays representing queued tracks. Each element is `[className, displayName, duration]`.
- `ZeusJukebox_autoplay`: Boolean — Whether autoplay is enabled.

#### Zeus Management
- `ZeusJukebox_registeredZeuses`: Array — Array of player objects representing all Zeuses that currently have the Zeus Jukebox dialog open. Used for synchronization between multiple Zeus players. Players are added when opening the dialog and removed when closing it.

### Namespace `uiNamespace`

#### Music List & Loading
- `ZeusJukebox_musicTracks`: HashMap — Cached map of music class name → track data array. Each value is an array: `[displayName, durationSeconds, soundFile, theme, isMissionMusic]`
- `ZeusJukebox_isPopulating`: Boolean — Flag indicating music list is currently being populated. Used to prevent concurrent population operations.
- `ZeusJukebox_groupedTracks`: HashMap — Cached map of grouped tracks by category (theme or addon).
- `ZeusJukebox_expandedCategories`: HashMap — Map tracking which categories are expanded (true) or collapsed (false) in the music list.
- `ZeusJukebox_groupingMode`: String — Current grouping mode: "musicclass" (default), "theme", or "addon".
- `ZeusJukebox_trackData`: HashMap — Alternative storage for track data during population.
- `ZeusJukebox_filterFavoritesOnly`: Boolean — Whether to show only favorite tracks in the music list.

#### Currently Playing State
- `ZeusJukebox_previewPlaying`: Boolean — Whether the preview track is currently playing.
- `ZeusJukebox_previewStartTime`: Number — Game time when preview playback started. Used to calculate elapsed time and preserve preview position.
- `ZeusJukebox_previewPausedAt`: Number — Time position where preview was paused (in seconds). Used for resume functionality.
- `ZeusJukebox_previewDuration`: Number — Duration of the currently previewed track in seconds.
#### Preview Playback State
- `ZeusJukebox_previewTrack`: String — Class name of the track currently loaded in the preview area. Empty string when no preview is loaded. 
- `ZeusJukebox_previewPlaying`: Boolean — Whether the preview track is currently playing. 
- `ZeusJukebox_previewStartTime`: Number — Game time when preview playback started. Used to calculate elapsed time and preserve preview position. 
- `ZeusJukebox_previewPausedAt`: Number — Time position where preview was paused (in seconds). Used for resume functionality. 
- `ZeusJukebox_previewUpdateHandle`: Script Handle — Handle to the preview update loop script. Used to terminate the loop when stopping preview. 

#### UI State
- `ZeusJukebox_fontSizeLevel`: Number — Current font size level for UI elements. Range: 0-4, where 2 is default size. Maximum available level is limited by `ZeusJukebox_maxFontSizeLevel`.
- `ZeusJukebox_maxFontSizeLevel`: Number — Maximum font size level allowed based on display aspect ratio. Set once on first dialog open. Value: 4 for ultra-wide (21:9+), 2 for standard (16:9).
- `ZeusJukebox_selectedQueueTrack`: String — Class name of the currently selected track in the queue listbox. Used to restore selection after queue updates. Empty string when no selection.
- `ZeusJukebox_selectedQueueIdx`: Number — Index of the currently selected track in the queue listbox. Used together with selectedQueueTrack to restore selection, especially when there are duplicate tracks. -1 when no selection.
- `ZeusJukebox_isListeningLocally`: Boolean — Whether the Zeus is listening to the currently playing track locally. Can be toggled to mute/unmute for preview purposes.
- `ZeusJukebox_autoplayPreview`: Boolean — Whether autoplay preview is enabled. When true, any track loaded into the preview area immediately starts playing (and locally mutes the currently playing track if needed). Defaults to false.
- `ZeusJukebox_lastMissionName`: String — Name of the last mission where the dialog was opened. Used to detect mission changes and trigger music list rebuild to include potential mission music.

#### Favorites
- `ZeusJukebox_favorites`: Array — Array of class names marked as favorite tracks. Synchronized with profileNamespace for persistence. 

### Namespace `profileNamespace`
- `ZeusJukebox_favorites`: Array — Array of class names marked as favorite tracks. Persisted across game sessions. Loaded into uiNamespace on dialog open.

## Notes
- **missionNamespace** is used for state shared across all Zeus users (currently playing, queue, autoplay, looping).
- **uiNamespace** is used for local state per-Zeus (preview, favorites, UI preferences, music list cache).
- **profileNamespace** is used for persistent state across game sessions (favorites only).
- All mod runtime variables use the `ZeusJukebox_` prefix