/* also executed on JIP, which is intended - the engine loads
 * Eden Arsenal-saved loadout on JIP, just not on respawns */

if (isDedicated) exitWith {};

[player, [missionNamespace, "A3MT_arsenal_inv"]] call BIS_fnc_saveInventory;

player addEventHandler ["Respawn", {
    [player, [missionNamespace, "A3MT_arsenal_inv"]] call BIS_fnc_loadInventory;
}];
