/*
 * load gear (loadout) saved in a global variable onto '_unit'
 */

params ["_unit"];

[_unit, A3MT_saved_spawn_gear, true, true] call ace_common_fnc_setAllGear;
