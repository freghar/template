/*
 * adds init and respawn event handlers that load the gear
 */

private ["_handle"];

_handle = compile preprocessFileLineNumbers "features\Custom_Factions\loadouts\loadouts.sqf";
[] call _handle;

["CAManBase", "init", { (_this select 0) call A3MT_fnc_loadGearFromFile }] call CBA_fnc_addClassEventHandler;
["CAManBase", "respawn", { (_this select 0) call A3MT_fnc_loadGearFromFile }] call CBA_fnc_addClassEventHandler;
