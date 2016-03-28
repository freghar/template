/*
 * save gear (loadout) of '_unit' into a global variable
 */

params ["_unit"];

A3MT_saved_spawn_gear = _unit call ace_common_fnc_getAllGear;
