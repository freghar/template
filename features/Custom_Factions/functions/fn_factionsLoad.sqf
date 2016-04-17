/*
 * adds init and respawn CBA XEHs to load the gear
 */

/* since we include it via preprocessor, all comments or ifdefs/macros
 * are taken care of at preprocessing time */
private _classfiles = [
#include "..\loadouts\classes.txt"
];

/* pre-parse class specs in-place for easier iteration later on, so that
 * the resulting array consists of 3-member [class, inherit, [codes]],
 * ie.
 *   "classname"                -> ["classname", false, [<CODE:classname.sqf>]]
 *   "classname+"               -> ["classname", true,  [<CODE:classname.sqf>]]
 *   ["classname"]              -> ["classname", false, [<CODE:classname.sqf>]]
 *   ["classname", "file"]      -> ["classname", false, [<CODE:file>]]
 *   ["classname", "f1", "f2"]  -> ["classname", false, [<CODE:f1>, <CODE:f2>]]
 */
_classfiles = _classfiles apply {
    _x params ["_class"];
    private _files = [];
    if (typeName _x == "ARRAY") then {
        _x deleteAt 0;  /* class name */
        _files = _x;
    };
    /* catch array spec without filename as well */
    if (count _files == 0) then {
        _files = [format ["%1.sqf", _class]];
    };
    _files = _files apply {
        compile preprocessFileLineNumbers
            format ["features\Custom_Factions\loadouts\%1", _x];
    };
    /* use for inheritance? */
    private _inherit = false;
    if ((_class select [count _class - 1]) == "+") then {
        _inherit = true;
        _class = ((_class splitString "+") select 0);
    };
    [_class, _inherit, _files];
};

/* "slow" table, for all classes */
A3MT_factions_classcodes = _classfiles;
/* "fast" per-class cache table, filled in dynamically by fn_factionsGetCodes */
A3MT_factions_idx = [];
A3MT_factions_data = [];

/* call each of the cached class data for a given unit, runtime */
private _call_classes = {
    0 = (_this select 0) spawn {
        /* ideally, we would wait for !isNull _this (though that doesn't work),
         * just wait in case _this == player */
        if (!isDedicated) then { waitUntil { !isNull player } };
        if (!local _this) exitWith {};
#ifdef FEAT_ARSENAL_RESPAWN
        /* no way to detect if player uses arsenal or not, so disable
         * faction-based loadout for all players, assume all use it */
        if (_this == player) exitWith {};
#endif
        { _this call _x } forEach (_this call A3MT_fnc_factionsGetCodes);
    };
};

/* hook event handlers */
{
    ["All", _x, _call_classes] call CBA_fnc_addClassEventHandler;
} forEach ["init", "respawn"];
