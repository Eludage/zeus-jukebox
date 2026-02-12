/*
 * Author: Eludage
 * Handles the increase font size button click.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Boolean: true on success, false on failure
 *
 * Example:
 * [] call ZeusJukebox_fnc_onIncreaseFonteSize;
 */
disableSerialization;
[1] call ZeusJukebox_fnc_changeFontSize;
true;