# Development Help

This document contains helpful development-oriented references for working on ZeusJukebox. It contains the control ID reference.

## Building the Mod

The mod is packed into a `.pbo` and deployed to your local Arma 3 mods folder using `build.bat` in the repository root.

### Prerequisites

- [Arma 3 Tools](https://store.steampowered.com/app/233800/Arma_3_Tools/) installed via Steam (provides `AddonBuilder.exe`)
- A `.biprivatekey` file for signing the PBO *(optional — if the key is not found, the PBO is built unsigned)*

### Setup

1. Copy `.env.example` to `.env` in the repository root.
2. Fill in all paths in `.env` to match your local machine:

| Variable | Description |
|---|---|
| `ADDONBUILDER` | Path to `AddonBuilder.exe` |
| `SOURCE` | Path to the mod source directory (this repo) |
| `DEST` | Output path for the packed `.pbo` (should end in `ZeusJukebox.pbo`) |
| `PRIVATEKEY` | Path to your `.biprivatekey` file *(optional — omit or point to a non-existent file to skip signing)* |
| `TEMPDIR` | Temp directory used by AddonBuilder during packing |
| `PROJECTDIR` | Root project directory (parent of the mod source) |
| `EXCLUDELIST` | Path to AddonBuilder's `exclude.lst` file |
| `EXPORTDIR` | Directory where AddonBuilder writes the output `.pbo` folder |
| `DEPLOYDIR` | Target `addons` folder of your local `@Zeus Jukebox` mod |

> `.env` is git-ignored and never committed. Only `.env.example` is tracked.

### Running the Build

Double-click `build.bat` or run it from a terminal:

```bat
build.bat
```

The script will:
1. Load all paths from `.env`
2. Read the PBO prefix from `$PBOPREFIX$`
3. Run AddonBuilder to pack and sign the PBO, using `AddonBuilderIncludes.txt` to determine which file types are copied directly (`.sqf`, `.hpp`, `.cpp`, `.paa`, `.p3d`)
4. On success: clear the deploy folder and move the new `.pbo` and `.bisign` files into it

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
    - 15505 → MusicGroupByAddonBtn — Toggles to grouping by Addon (visible when current mode is not Addon)
    - 15506 → MusicFavoriteOff — Favorites filter OFF button (visible when filter is inactive)
    - 15507 → MusicFavoriteOn — Favorites filter ON button (visible when filter is active)
    - 15508 → MusicMarkFavoriteBtn — "Mark Favorite" button (visible when the selected track is not a favorite)
    - 15509 → MusicGroupByThemeBtn — Toggles to grouping by Theme (visible when current mode is not Theme)
    - 15510 → MusicGroupByMusicClassBtn — Toggles to grouping by Music Class (visible when current mode is not Music Class)
    - 15511 → MusicListSettings — Cog-wheel button; shows the Music List Settings overlay
    - 15512 → MusicHistoryBtn — "History" button; shows the Track History overlay
    - 15513 → MusicUnmarkFavoriteBtn — "Unmark Favorite" button (visible when the selected track is already a favorite); `updateUiFavoriteMarkBtn` toggles 15508/15513 visibility based on `ZeusJukebox_selectedMusicListTrack` vs `ZeusJukebox_favorites`, called from `onMusicListEntrySelected` and `onFavoriteMarkBtn`
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
    - 15613 → CurrentlyPlayingNoSongText — "No song selected" placeholder panel covering the entire Currently Playing box, shown when no track is loaded
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
    - 15710 → ManageSongListBtn — Opens Manage Song List dialog (placeholder)
  - Music List Settings
    - 15800 → SettingsOverlayDim — Decorative dim panel covering the full dialog area while the overlay is open (ZJ_RscPanel, CT_STATIC, never captures clicks); no text, intentionally excluded from fn_changeFontSize.sqf
    - 15801 → SettingsOverlayBackground — Music List Settings overlay panel, hidden by default, shown over the rest of ZeusJukebox_Dialog by ZeusJukebox_fnc_onMusicListSettings
    - 15802 → SettingsOverlayTitle — "Music List Settings" title, top-left corner aligned with the close button
    - 15803 → SettingsOverlayCloseButton — Red "X" button, hides the overlay via ZeusJukebox_fnc_onMusicListSettingsClose
    - 15804 → SettingsOverlayBorder — White ST_FRAME outline drawn around SettingsOverlayBackground; no text, so intentionally excluded from fn_changeFontSize.sqf
    - 15811 → SettingsOverlaySortLabel — "Currently Sorting:" label
    - 15812 → SettingsSortAlphabeticalBtn — Sort field toggle; visible when `ZeusJukebox_sortMode` is "alphabetical", switches to "time"
    - 15813 → SettingsSortByTimeBtn — Sort field toggle; visible when `ZeusJukebox_sortMode` is "time", switches to "alphabetical"
    - 15814 → SettingsSortAscendingBtn — Sort direction toggle; visible when `ZeusJukebox_sortDirection` is "ascending", switches to "descending"
    - 15815 → SettingsSortDescendingBtn — Sort direction toggle; visible when `ZeusJukebox_sortDirection` is "descending", switches to "ascending"
    - 15821 → SettingsOverlayHideNoDurationLabel — "Hiding Music with no duration:" label
    - 15822 → SettingsHideNoDurationYesBtn — Visible when `ZeusJukebox_hideNoDuration` is true, click to stop hiding
    - 15823 → SettingsHideNoDurationNoBtn — Visible when `ZeusJukebox_hideNoDuration` is false, click to start hiding
    - 15831 → SettingsOverlayHideBlacklistedLabel — "Hiding blacklisted Music:" label
    - 15832 → SettingsHideBlacklistedYesBtn — Visible when `ZeusJukebox_hideBlacklisted` is true, click to stop hiding
    - 15833 → SettingsHideBlacklistedNoBtn — Visible when `ZeusJukebox_hideBlacklisted` is false, click to start hiding  
  - Music List Settings — interaction blocking mechanism
    - The dim panel (15800) is purely visual and cannot intercept clicks. The rest
      of the dialog is made non-interactive while the overlay is open by explicitly
      ctrlEnable false-ing every real interactive control in ZeusJukebox_Dialog
      (everything outside the 158xx range, including the gear button 15511 itself),
      done in ZeusJukebox_fnc_onMusicListSettings. ZeusJukebox_fnc_onMusicListSettingsClose
      mirrors this with ctrlEnable true (then re-runs fn_changeFontSize/
      fn_updateUiCurrentlyPlaying/fn_updateUiQueue to restore their namespace-driven
      conditional enable states). The only way to close the overlay is the red X
      button (15803) — clicking outside the panel no longer dismisses it.
    - 15512 (MusicHistoryBtn) is also disabled while this overlay is open, and
      15511 (the gear button) is disabled while the Track History overlay is open,
      so the two overlays can never be shown on top of each other.
    - fn_updateUiCurrentlyPlaying and fn_updateUiQueue can also be re-invoked while
      the overlay is open by code that has nothing to do with it (the 0.2s
      playback-progress loop in fn_openJukeboxDialog.sqf, or a remote trigger fired
      when another Zeus client changes playback/queue state) and would otherwise
      silently re-enable the buttons the overlay just disabled. Both functions check
      the ZeusJukebox_settingsOverlayOpen uiNamespace flag and skip re-enabling while
      it's true, so those externally-triggered refreshes can't undo the block.
  - Track History
    - 15900 → HistoryOverlayDim — Decorative dim panel covering the full dialog area while the overlay is open; no text, intentionally excluded from fn_changeFontSize.sqf
    - 15901 → HistoryOverlayBackground — Track History overlay panel, hidden by default, shown over the rest of ZeusJukebox_Dialog by ZeusJukebox_fnc_onTrackHistoryOpen
    - 15902 → HistoryOverlayTitle — "Track History" title, top-left corner aligned with the close button
    - 15903 → HistoryOverlayCloseButton — Red "X" button, hides the overlay via ZeusJukebox_fnc_onTrackHistoryClose
    - 15904 → HistoryOverlayBorder — White ST_FRAME outline drawn around HistoryOverlayBackground; no text, so intentionally excluded from fn_changeFontSize.sqf
    - 15905 → HistoryList — Listbox of previously played tracks, newest first, populated by ZeusJukebox_fnc_updateUiHistory from `ZeusJukebox_trackHistory`; double-click adds the track back to the queue via ZeusJukebox_fnc_onTrackHistoryDblClick (keeps the exact soundFile from the history entry rather than re-resolving it, to avoid mission/addon classname-shadowing ambiguity)
    - 15906 → HistoryClearBtn — Clears `ZeusJukebox_trackHistory` for all Zeus clients via ZeusJukebox_fnc_onClearTrackHistoryBtn
  - Track History — interaction blocking mechanism
    - Mirrors the Music List Settings mechanism above exactly: the dim panel (15900)
      is purely visual, the rest of the dialog (everything outside the 159xx range,
      including both the gear button 15511 and the History button 15512 itself) is
      made non-interactive via ctrlEnable false in ZeusJukebox_fnc_onTrackHistoryOpen,
      mirrored by ZeusJukebox_fnc_onTrackHistoryClose (which also re-runs
      fn_changeFontSize/fn_updateUiCurrentlyPlaying/fn_updateUiQueue to restore their
      namespace-driven conditional enable states). The only way to close the overlay
      is the red X button (15903). The ZeusJukebox_historyOverlayOpen uiNamespace flag
      serves the same "don't let externally-triggered refreshes undo the block"
      purpose as ZeusJukebox_settingsOverlayOpen does for the Settings overlay.
  - Manage Song Lists
    - 16000 → ManageSongListsOverlayDim — Decorative dim panel covering the full dialog area while the overlay is open; no text, intentionally excluded from fn_changeFontSize.sqf
    - 16001 → ManageSongListsOverlayBackground — Manage Song Lists overlay panel, hidden by default, shown over the rest of ZeusJukebox_Dialog by ZeusJukebox_fnc_onManageSongList
    - 16002 → ManageSongListsOverlayTitle — "Manage Song Lists" title, top-left corner aligned with the close button
    - 16003 → ManageSongListsOverlayCloseButton — Red "X" button, hides the overlay via ZeusJukebox_fnc_onManageSongListClose
    - 16004 → ManageSongListsOverlayBorder — White ST_FRAME outline drawn around ManageSongListsOverlayBackground; no text, so intentionally excluded from fn_changeFontSize.sqf
    - 16010 → PlaylistNameLabel — "Playlist Name:" label
    - 16011 → PlaylistNameField — Edit field used by both "Save as New" (16012) and "Rename Selected" (16023)
    - 16012 → SaveNewPlaylistBtn — Saves the current queue as a new playlist named from 16011 via ZeusJukebox_fnc_onPlaylistSaveNew
    - 16013 → UpdateSelectedPlaylistBtn — Overwrites the selected playlist's tracks with the current queue via ZeusJukebox_fnc_onPlaylistUpdateSelected
    - 16020 → PlaylistsListLabel — "Saved Playlists:" label
    - 16021 → PlaylistsList — Listbox of saved playlists (name + track count), populated by ZeusJukebox_fnc_updateUiManageSongLists from `ZeusJukebox_playlists`; `onLBSelChanged` calls ZeusJukebox_fnc_onPlaylistEntrySelected
    - 16022 → LoadPlaylistBtn — Appends the selected playlist's tracks to the queue via ZeusJukebox_fnc_onPlaylistLoad (calls the shared ZeusJukebox_fnc_remoteAddClassNamesToQueue helper)
    - 16023 → RenamePlaylistBtn — Renames the selected playlist to the text in 16011 via ZeusJukebox_fnc_onPlaylistRename
    - 16024 → DeletePlaylistBtn — Deletes the selected playlist via ZeusJukebox_fnc_onPlaylistDelete, no confirmation prompt
  - Manage Song Lists — interaction blocking mechanism
    - Mirrors the Music List Settings mechanism above exactly: the dim panel (16000)
      is purely visual, the rest of the dialog (everything outside the 160xx range,
      including the gear button 15511, the History button 15512, and the Manage Song
      List button 15710 itself) is made non-interactive via ctrlEnable false in
      ZeusJukebox_fnc_onManageSongList, mirrored by ZeusJukebox_fnc_onManageSongListClose
      (which also re-runs fn_changeFontSize/fn_updateUiCurrentlyPlaying/fn_updateUiQueue
      to restore their namespace-driven conditional enable states). The only way to
      close the overlay is the red X button (16003). The
      ZeusJukebox_manageSongListsOverlayOpen uiNamespace flag serves the same
      "don't let externally-triggered refreshes undo the block" purpose as
      ZeusJukebox_settingsOverlayOpen does for the Settings overlay — both flags are
      checked (OR'd together) in fn_updateUiCurrentlyPlaying.sqf and fn_updateUiQueue.sqf.
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
- `ZeusJukebox_currentlyPlayingSoundFile`: String — Sound file path (from `CfgMusic >> sound`) of the currently playing track. Stored alongside the class name so looping and resume can replay the exact source file, which matters when the same class name exists in both an addon and the mission config.
- `ZeusJukebox_isFading`: Boolean — Whether the currently playing track is currently fading out.
- `ZeusJukebox_fadeStartTime`: Number — `serverTime` at which the fade out started. Used to calculate the remaining fade countdown displayed on the Fade button. Reset to `0` when fading completes.

#### Queue Management
- `ZeusJukebox_queue`: Array — Array of track info arrays representing queued tracks. Each element is `[className, displayName, duration, soundFile]`.
- `ZeusJukebox_autoplay`: Boolean — Whether autoplay is enabled.

#### Track History
- `ZeusJukebox_trackHistory`: Array — Array of previously played tracks, oldest first. Each element is `[className, displayName, duration, soundFile, playedAt]`, where `playedAt` is the `serverTime` the track started playing. Appended to in `fn_remotePlaySong.sqf` on every play (queue or manual); capped at the 50 most recent entries (oldest dropped first) to bound growth over a long session. Mission-scoped like `ZeusJukebox_queue` — not persisted to `profileNamespace`, so it resets with each new mission. Read by `fn_updateUiHistory.sqf` (Track History overlay listbox) and `fn_updateUiMusicList.sqf` (played-track indicator/tint in the Available Music list), both keyed on the `className + "|" + soundFile` composite to avoid cross-mod classname collisions.

#### Zeus Management
- `ZeusJukebox_registeredZeuses`: Array — Array of player objects representing all Zeuses that currently have the Zeus Jukebox dialog open. Used for synchronization between multiple Zeus players. Players are added when opening the dialog and removed when closing it.

### Namespace `uiNamespace`

#### Music List & Loading
- `ZeusJukebox_isPopulating`: Boolean — Flag indicating music list is currently being populated. Used to prevent concurrent population operations.
- `ZeusJukebox_groupedTracks`: HashMap — Cached map of grouped tracks by category (theme or addon). This is the actual track cache read by `updateUiMusicList`.
- `ZeusJukebox_expandedCategories`: HashMap — Map tracking which categories are expanded (true) or collapsed (false) in the music list.
- `ZeusJukebox_groupingMode`: String — Current grouping mode: "musicclass" (default), "theme", or "addon".
- `ZeusJukebox_filterFavoritesOnly`: Boolean — Whether to show only favorite tracks in the music list.

> **Dead variables (read or written, but not both):** `ZeusJukebox_musicTracks` is read by `fn_updateUiPreviewArea.sqf` (expecting a HashMap of `[displayName, durationSeconds, soundFile, theme, isMissionMusic]`) but never written anywhere, so the lookup always misses and the function always falls back to `ZeusJukebox_fnc_getTrackConfig`. `ZeusJukebox_trackData` is written by `fn_updateUiMusicList.sqf` (as an Array, not a HashMap) but never read anywhere. Both look like leftovers from a superseded caching design — `ZeusJukebox_groupedTracks` is what's actually used. Left in place rather than removed since that's a code change, not a doc fix; flagging here so they aren't mistaken for live behavior.

#### Preview Playback State
- `ZeusJukebox_previewTrack`: String — Class name of the track currently loaded in the preview area. Empty string when no preview is loaded.
- `ZeusJukebox_previewSoundFile`: String — Sound file path of the track loaded in preview. Stored alongside the class name so `onPreviewPlay` plays the correct source file when the same class name exists in both an addon and the mission config.
- `ZeusJukebox_previewPlaying`: Boolean — Whether the preview track is currently playing.
- `ZeusJukebox_previewStartTime`: Number — Game time when preview playback started. Used to calculate elapsed time and preserve preview position.
- `ZeusJukebox_previewPausedAt`: Number — Time position where preview was paused (in seconds). Used for resume functionality.
- `ZeusJukebox_previewDuration`: Number — Duration of the currently previewed track in seconds.
- `ZeusJukebox_previewUpdateHandle`: Script Handle — Handle to the preview update loop script. Used to terminate the loop when stopping preview.

#### UI State
- `ZeusJukebox_selectedMusicListTrack`: String — `"className|soundFile"` composite key (see `ZeusJukebox_favorites` below) of the track most recently selected in the music list. Set by `onMusicListEntrySelected` and `onQueuePreview` when loading a track into the preview area; read by `onFavoriteMarkBtn` as the favorite key and by `updateUiFavoriteMarkBtn` to pick which of 15508/15513 to show.
- `ZeusJukebox_fontSizeLevel`: Number — Current font size level for UI elements. Range: 0-4, where 2 is default size. Maximum available level is limited by `ZeusJukebox_maxFontSizeLevel`.
- `ZeusJukebox_maxFontSizeLevel`: Number — Maximum font size level allowed based on display aspect ratio. Set once on first dialog open. Value: 4 for ultra-wide (21:9+), 2 for standard (16:9).
- `ZeusJukebox_selectedQueueTrack`: String — Class name of the currently selected track in the queue listbox. Used to restore selection after queue updates. Empty string when no selection.
- `ZeusJukebox_selectedQueueIdx`: Number — Index of the currently selected track in the queue listbox. Used together with selectedQueueTrack to restore selection, especially when there are duplicate tracks. -1 when no selection.
- `ZeusJukebox_isListeningLocally`: Boolean — Whether the Zeus is listening to the currently playing track locally. Can be toggled to mute/unmute for preview purposes.
- `ZeusJukebox_autoplayPreview`: Boolean — Whether autoplay preview is enabled. When true, any track loaded into the preview area immediately starts playing (and locally mutes the currently playing track if needed). Defaults to false.
- `ZeusJukebox_lastMissionName`: String — Name of the last mission where the dialog was opened. Used to detect mission changes and trigger music list rebuild to include potential mission music.
- `ZeusJukebox_sortMode`: String — "alphabetical" or "time". Set by the Music List Settings overlay toggle buttons (15812/15813). Defaults to "alphabetical". Read by `updateUiMusicList`, which sorts the tracks within each category by display name or duration accordingly; the toggle buttons call `updateUiMusicList` after changing it.
- `ZeusJukebox_sortDirection`: String — "ascending" or "descending". Set by the Music List Settings overlay toggle buttons (15814/15815). Defaults to "ascending". Read by `updateUiMusicList`, which sorts the tracks within each category ascending or descending accordingly; the toggle buttons call `updateUiMusicList` after changing it.
- `ZeusJukebox_hideNoDuration`: Boolean — Whether to hide tracks with no duration from the Available Music list. Set by the Music List Settings overlay toggle buttons (15822/15823). Defaults to false. Read by `updateUiMusicList`, which filters out tracks whose `CfgMusic` entry has no `duration` set; the toggle buttons call `updateUiMusicList` after changing it.
- `ZeusJukebox_hideBlacklisted`: Boolean — Whether to hide blacklisted tracks from the Available Music list. Set by the Music List Settings overlay toggle buttons (15832/15833). Defaults to false. Read by `updateUiMusicList`, which filters out tracks whose classname appears in `ZeusJukebox_Blacklist >> entries` (see `blacklist.hpp`); the toggle buttons call `updateUiMusicList` after changing it.
- `ZeusJukebox_settingsOverlayOpen`: Boolean — Whether the Music List Settings overlay is currently open. Set by `onMusicListSettings`/`onMusicListSettingsClose`. Read by `updateUiCurrentlyPlaying` and `updateUiQueue` (OR'd with `ZeusJukebox_manageSongListsOverlayOpen`) so externally-triggered refreshes (the playback-progress loop, other Zeus clients' remote triggers) can't re-enable buttons the overlay disabled. Defaults to false.
- `ZeusJukebox_historyOverlayOpen`: Boolean — Whether the Track History overlay is currently open. Set by `onTrackHistoryOpen`/`onTrackHistoryClose`. Same externally-triggered-refresh protection role as `ZeusJukebox_settingsOverlayOpen`, for the Track History overlay. Defaults to false.
- `ZeusJukebox_manageSongListsOverlayOpen`: Boolean — Whether the Manage Song Lists overlay is currently open. Set by `onManageSongList`/`onManageSongListClose`. Read by `updateUiCurrentlyPlaying` and `updateUiQueue` (OR'd with `ZeusJukebox_settingsOverlayOpen`) for the same externally-triggered-refresh protection. Defaults to false.
- `ZeusJukebox_selectedPlaylistName`: String — Name of the currently selected playlist in the Manage Song Lists overlay listbox (16021). Used to restore selection after the listbox is rebuilt, and as the target for Update/Rename/Load/Delete. Empty string when no selection.

#### Favorites
- `ZeusJukebox_favorites`: Array — Array of `"className|soundFile"` composite-key strings (same `"|"` delimiter convention as `ZeusJukebox_Blacklist >> entries[]` and the music listbox's `lbSetData`) identifying favorited `CfgMusic` tracks. Composite keying avoids the same classname-collision problem the blacklist entry describes: the same class name can exist in both an addon and the mission's own config as genuinely different tracks, so favoriting one must not favorite the other. For mission-sourced tracks, the `soundFile` component is the constant `"mission_music"` instead of the literal (mission-relative, unstable-across-missions) `sound[]` path, since favorites persist across missions and a real mission-relative path would silently stop matching once a Zeus reuses the same className in a different mission. Synchronized with profileNamespace for persistence.

#### Playlists
- `ZeusJukebox_playlists`: Array — Array of `[name, classNames]` saved playlist records, where `classNames` is an array of `CfgMusic` class name strings. Synchronized with profileNamespace for persistence via `ZeusJukebox_fnc_savePlaylists`.

### Namespace `profileNamespace`
- `ZeusJukebox_favorites`: Array — Array of `"className|soundFile"` composite-key strings (see the `uiNamespace` entry above for the full key format, including the `"mission_music"` constant used for mission-sourced tracks). Persisted across game sessions. Loaded into uiNamespace on dialog open. Pre-2.0.0 plain-className favorites are re-keyed by `ZeusJukebox_fnc_migrateProfileData`'s `1.0.0 → 2.0.0` step (tracks that no longer resolve to any `CfgMusic` entry are dropped).
- `ZeusJukebox_playlists`: Array — Array of `[name, classNames]` saved playlist records. Persisted across game sessions via `ZeusJukebox_fnc_savePlaylists`. Loaded into uiNamespace on dialog open via `ZeusJukebox_fnc_loadPlaylists`.

### Static config data (not a namespace variable)
- `ZeusJukebox_Blacklist >> entries[]` (defined in `blacklist.hpp`, `#include`d from `config.cpp`): Array of `"<className>|<soundFile>"` strings identifying `CfgMusic` tracks with known-bad metadata (wrong name/duration) from mods whose authors won't fix them upstream. Matched on both classname and sound file path (not classname alone) so a classname collision with an unrelated, correctly-tagged track from a different mod isn't hidden by mistake — same `"|"` delimiter convention `updateUiMusicList` already uses for the music listbox's `lbSetData`. Read by `updateUiMusicList` via `getArray (configFile >> "ZeusJukebox_Blacklist" >> "entries")` and filtered out when `ZeusJukebox_hideBlacklisted` is true. To blacklist a new track, add an `"className|soundFile"` entry to the array in `blacklist.hpp` and rebuild - there's no in-game way to edit this list.

## Notes
- **missionNamespace** is used for state shared across all Zeus users (currently playing, queue, track history, autoplay, looping).
- **uiNamespace** is used for local state per-Zeus (preview, favorites, UI preferences, music list cache).
- **profileNamespace** is used for persistent state across game sessions (favorites and saved playlists).
- All mod runtime variables use the `ZeusJukebox_` prefix

---

## Checklist: Adding a New Control

Follow these steps every time a new interactive control (button, edit field, listbox, etc.) is added to the dialog.

### 1. Define the control in `dialogs.hpp`
- Add a new class inside the appropriate section of `Controls` (or `ControlsBackground` for visual-only panels).
- Inherit from the correct base class (`ZJ_RscButton`, `ZJ_RscTextLabel`, `ZJ_RscEdit`, `ZJ_RscListbox`, `ZJ_RscPanel`).
- Assign a unique `idc` following the existing numbering convention:
  | Range   | Section                |
  |---------|------------------------|
  | 15011   | Misc (Close button)    |
  | 151xx   | Box title labels       |
  | 152xx   | Track Info             |
  | 153xx   | Preview                |
  | 154xx   | Options / Import-Export|
  | 155xx   | Music List             |
  | 156xx   | Currently Playing      |
  | 157xx   | Queue                  |
  | 158xx   | Music List Settings Overlay |
  | 159xx   | Track History Overlay |
  | 160xx   | Manage Song Lists Overlay |
- Set `idc = -1` only for purely decorative elements that will never be accessed by scripts.
- Wire the `action` (buttons) or relevant event handler (`onKeyUp`, `onLBSelChanged`, etc.) to the corresponding function: `"[] call ZeusJukebox_fnc_<functionName>;"`.
- Add a `tooltip` for any button whose purpose is not immediately obvious from its label.
- Use only macros or defined constants for colors and sizes — never hardcode values.

### 2. Create the action function in `functions/`
- Place the file in the subdirectory that matches its logical group:
  | Subdirectory                        | Purpose                                 |
  |-------------------------------------|-----------------------------------------|
  | `functions/actions/musiclist/`      | Music list interactions                 |
  | `functions/actions/musiclistSettings/` | Music List Settings overlay toggles  |
  | `functions/actions/currentlyPlaying/` | Currently Playing section buttons    |
  | `functions/actions/preview/`        | Preview section buttons                 |
  | `functions/actions/queue/`          | Queue section buttons                   |
  | `functions/actions/history/`        | Track History overlay buttons           |
  | `functions/actions/options/`        | Options section buttons                 |
  | `functions/ui/`                     | UI update/state management              |
  | `functions/core/`                   | Core / lifecycle functions              |
- Name the file `fn_<functionName>.sqf` matching the name used in the `action` field.
- Include the standard header comment block at the top (Author, description, Arguments, Return Value, Example).
- Always return a boolean (`true`/`false`).

### 3. Register the function in `config.cpp`
- Add a `class <functionName> {};` entry inside the correct `class actions_*` or other category block, with a short inline comment describing the button/purpose.

### 4. Add the IDC to `fn_changeFontSize.sqf`
- Open `functions/ui/fn_changeFontSize.sqf`.
- Add the IDC to the appropriate list:
  - `_listBigButtons` — large standalone buttons (e.g. Close).
  - `_listTitleLabels` — section header labels.
  - `_listNormalLabels` — everything else (buttons, value labels, edit fields, listboxes).
- Append the IDC to the correct group's line, keeping the inline comment up to date.
- Skip this step only for controls with `idc = -1` (decorative panels/lines).

### 5. Document the control in `doc/DEVELOPMENT_HELP.md`
- Add a line to the **Dialog and Control ID Reference** section under the correct heading:
  ```
  - <idc> → <ClassName> — brief purpose
  ```
## Versioning and Data Migration

This section describes how to handle breaking changes to persistent data stored in `profileNamespace`.

### Current Version
The current mod version is retrieved via `ZeusJukebox_fnc_getModVersion`.

> **IMPORTANT**: Only update the return value in `functions/utilities/fn_getModVersion.sqf` when there are **breaking changes** to persistent data or the mod's structure.

### Migration Process

1.  **Define the new version**: Update `functions/utilities/fn_getModVersion.sqf` with the new version number (e.g., `"1.1.0"`).
2.  **Implement Migration Logic**: Add a new `if` block in `functions/utilities/fn_migrateProfileData.sqf` to handle the transition from the previous version to the new one.
    *   The function iterates through migration steps sequentially, ensuring users upgrading from very old versions are brought up to date through all intermediate steps.
3.  **Execution**: The migration logic is automatically executed in `functions/core/fn_openJukeboxDialog.sqf` every time the dialog is opened.

### Data Migration Example
If you rename a variable or change the structure of an array in `profileNamespace`, add a transformation step within the appropriate `if` block in `fn_migrateProfileData.sqf`.
