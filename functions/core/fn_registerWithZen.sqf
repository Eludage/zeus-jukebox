/*
 * Registers the Jukebox as a Zen custom module on client startup (postInit).
 * Waits for Zen to be available before registering.
 * Runs only when Zen is present and not on a dedicated server.
 */

// Don't run on dedicated servers
if (isDedicated) exitWith {};

// Spawn in a scheduled environment to allow sleep/waitUntil
[] spawn {
    private _maxWait = 30; // seconds - longer wait to ensure mission is fully loaded
    private _interval = 0.5; // seconds
    private _waited = 0;

    // Wait for Zen function to be available
    while { _waited < _maxWait && isNil "zen_custom_modules_fnc_register" } do {
        sleep _interval;
        _waited = _waited + _interval;
    };

    if (isNil "zen_custom_modules_fnc_register") exitWith {
        diag_log "[ZeusJukebox] Warning: ZEN mod is required but not loaded. Jukebox will not be available in Zeus.";
        systemChat "[ZeusJukebox] Warning: ZEN mod is required but not loaded. Jukebox will not be available in Zeus.";
    };

    // Register the module in Zen's custom modules list
    ["Audio", "Zeus Jukebox", {
        [] call ZeusJukebox_fnc_openJukeboxDialog;
    }, "\ZeusJukebox\zeusjukebox_icon.paa"] call zen_custom_modules_fnc_register;

    diag_log "[ZeusJukebox] Successfully registered with Zen custom modules.";
};