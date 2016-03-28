/* also called on first player spawn, watch out!
 * (_old will be objNull) */

params ["_new", "_old", "_type", "_delay"];

/* _type: 2 == "INSTANT" (at corpse)
 *        3 == "BASE"    (on a marker)
 */

/*
 * exclude first spawn as !isNull _old - we can't check for the loadout
 * to be [], because this handler gets called even on first spawn and
 * *after* init.sqf, which saves the loadout - restoring it here wouldn't
 * hurt, but causes unnecessary animations and code to run
 * https://community.bistudio.com/wiki/Initialization_Order
 */
if ((_type == 2 || _type == 3) && (!isNull _old)) then {
#ifdef FEAT_ARSENAL_RESPAWN_HIDEBODY
    hideBody _old;
#endif
    _new call A3MT_fnc_loadSpawnGear;
};
