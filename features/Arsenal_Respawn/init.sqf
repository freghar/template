/* also executed on JIP, which is intended - the engine loads
 * Eden Arsenal-saved loadout on JIP, just not on respawns */

if (isDedicated) exitWith {};

A3MT_arsenal_respawn_inv = getUnitLoadout player;
player addEventHandler ["Respawn", {
    player setUnitLoadout A3MT_arsenal_respawn_inv;
}];
