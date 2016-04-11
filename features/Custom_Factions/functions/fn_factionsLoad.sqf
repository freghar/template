/*
 * adds init and respawn CBA XEHs to load the gear
 */

/* since we include it via preprocessor, all comments or ifdefs/macros
 * are taken care of at preprocessing time */
private _classes = [
#include "..\loadouts\classes.txt"
];

/* takes class name as arg, returns CODE to be executed on init/respawn */
private _gen_load = {
    compile (
        "0 = (_this select 0) spawn {" +
            /* can't succeed with player local check (below) if it's null */
            "if (!isDedicated) then { waitUntil {!isNull player} }; " +
            "if (!local _this) exitWith {}; " +
#ifdef FEAT_ARSENAL_RESPAWN
            /* no way to detect if player uses arsenal or not, so disable
             * faction-based loadout for all players, assume all use it */
            "if (_this == player) exitWith {}; " +
#endif
            format [
                "_this execVM ""features\Custom_Factions\loadouts\%1.sqf""; ",
                _this
            ] +
        "}"
    )
};

{
    private _class = _x;
    {
        [_class, _x, _class call _gen_load] call CBA_fnc_addClassEventHandler;
    } forEach ["init", "respawn"];
} forEach _classes;
