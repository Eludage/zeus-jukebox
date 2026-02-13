# Zeus Jukebox

// TODO Fix link when releasing version 1.0.0

[Zeus Jukebox](https://steamcommunity.com/sharedfiles/filedetails/?edit=true&id=3665466082) is a client-side music management system for Arma 3, allowing Zeuses to control and play music during multiplayer missions with an intuitive interface.
The Beta version (testing new features) is available [here](https://steamcommunity.com/sharedfiles/filedetails/?id=3661185052)

## Features

### Music Browser
- **Available Music**: Browse all CfgMusic tracks organized by category
- **Search**: Filter tracks by name or class name using the search field
- **Collapsible Categories**: Click on category headers to expand/collapse
- **Track Info Panel**: View track name, class name, file path, and duration
- **Dynamic Font Size**: Adjust font size with +/- buttons for better readability
- **Mission Music Support**: Automatically loads music defined in mission description.ext

### Preview System
- **Local Preview**: Preview any track locally before playing it for everyone
- **Play/Pause Controls**: Full playback control for preview
- **Progress Bar**: Visual progress indicator with click-to-seek functionality
- **Time Display**: Shows elapsed time and total duration

### Currently Playing (Server-wide)
- **Play for All**: Play music for all players on the server
- **Play/Stop**: Start or stop playback for everyone
- **Fade Out (5s)**: Gradually fade out the current track over 5 seconds (not supported when running ACE)
- **Remove**: Immediately stop and clear the current track
- **Mute/Listen for Zeus**: Toggle whether you hear the server-wide music (useful when previewing)

### Queue System
- **Add to Queue**: Add tracks from preview to the queue
- **Queue Management**: 
  - Play: Move track to Currently Playing and start playback
  - Remove: Remove track from queue
  - Preview: Load track into preview section
  - Up/Down: Reorder tracks in the queue
- **Autoplay**: Toggle automatic playback of next queued track when current finishes

### Import/Export
- **Export Queue**: Export your queue as an array string for sharing
- **Import Queue**: Import a queue from an array string
- **Format**: `["ClassName1","ClassName2","ClassName3"]`

### Options
- **Font Size**: Adjust UI font size (5 levels: XS, S, M, L, XL)

## Installation

1. Subscribe to the mod on Steam Workshop
2. Enable the mod in the Arma 3 Launcher
3. Launch Arma 3 and open the Zeus menu in a mission
4. Access Zeus Jukebox through the Zeus modules menu Audio/Zeus Jukebox

## Adding Custom Mission Music

The Jukebox automatically detects music defined in your mission's `description.ext`. Add a `CfgMusic` class like this:

```cpp
class CfgMusic
{
    tracks[] = {};
    
    class MyCustomTrack
    {
        name = "My Custom Song";                         // Display name in Jukebox
        sound[] = {"music\my_song.ogg", db+0, 1.0};      // {path, volume, pitch}
        duration = 180;                                   // Length in seconds
    };
    
    class EpicBattleMusic
    {
        name = "Epic Battle Theme";
        sound[] = {"music\battle_theme.ogg", db+3, 1.0}; // db+3 = louder
        duration = 240;
    };
};
```

### Supported Audio Formats
- `.ogg` (recommended)
- `.wav`
- `.wss`

### File Structure Example for Mission Music
```
myMission.Stratis/
├── description.ext      # Contains CfgMusic definition
├── init.sqf
└── music/
    ├── my_song.ogg
    └── battle_theme.ogg
```

Custom mission music will appear under the "Mission Music" category in the Jukebox.

## Multiplayer Behavior

### Local (Per-Zeus, Not Synced)
- Preview playback
- Listen/Mute toggle state
- Favorites
- Selected track
- Font size preference

### Server-wide (Synced Across All Zeus Users)
- Currently Playing track
- Queue contents
- Autoplay toggle
- Looping toggle

**Note**: When any Zeus uses Play/Pause/Fade/Remove, all players hear it. Queue changes and UI updates are synchronized across all Zeus users who have the dialog open.

## Dependencies

- **Required**: ZEN (Zeus Enhanced) - The module registers through ZEN's custom modules system

## Documentation

The repository includes several developer-facing documents in the `doc/` folder:

- `DEVELOPMENT_HELP.md` — developer reference (file structure, dialog/control ID reference, namespaces, and variables).
- `ARCHITECTURE.md` — architecture overview (function organization, data flow patterns, design decisions).

## Building the Mod

Build the mod using Arma 3 Tools (Addon Builder) or compatible PBO packing tools.

## Known Limitations

- ZeusJukebox cannot detect music played from other sources (mission scripts, other mods, direct playMusic calls).
- ZeusJukebox cannot know whether players have turned their music volume down/off in game settings.
- Multiple Zeuses acting simultaneously may have race conditions (first action wins).
- **Music without duration**: If a music track has no duration declared in its config, it will show `0:00` in the music list and be defaulted to 3 minutes (180 seconds) when played. This can lead to music continuing to play silently after the actual track ends, or tracks being cut off early if they are longer than 3 minutes.

## Compatibility

### ACE3 Hearing
If ACE3 with the Hearing module is loaded, the **"Fade (5s)"** button will be automatically disabled. This is because ACE Hearing constantly updates sound and music volume according to the state of combat deafness, overriding any manual `fadeMusic` values set by scripts. The button will show a tooltip explaining this when hovered.

See: https://github.com/acemod/ACE3/issues/4029

## Special Thanks

- The Arma 3 modding community
- ZEN team for the excellent Zeus Enhanced framework
- [Sigma Security Group](https://disboard.org/de/server/288446755219963914) (we're always looking for new members)

## Credits

- **Author**: Eludage

## Note on Title Image in Steam

The title image for this workshop item is AI-generated. If you enjoy this mod and have artistic skills, feel free to create and contribute a replacement image! Contact the author or submit via the GitHub repository.