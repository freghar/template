/*
 * adds init and respawn CBA XEHs to load the gear
 */

/* since we include it via preprocessor, all comments or ifdefs/macros
 * are taken care of at preprocessing time */
private _classfiles = [
#include "..\loadouts\classes.txt"
];

/* pre-parse class specs in-place for easier iteration later on, so that
 *   "classname"                     ->  ["classname", ["classname.sqf"]]
 *   ["classname"]                   ->  ["classname", ["classname.sqf"]]
 *   ["classname", "file"]           ->  ["classname", ["file"]]
 *   ["classname", "file", "file2"]  ->  ["classname", ["file", "file2"]]
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
    [_class, _files];
};

/* pre-populate the list of classes (indexes) so that addition for a parent
 * class finds each child class specified by the user - otherwise, addition
 * for ie. CAManBase before B_Soldier_F is ever mentioned wouldn't affect
 * B_Soldier_F's code set */
private _classidx = [];
private _classdata = [];
{
    _x params ["_class"];
    /* if class doesn't exist in the idx list, add it and init empty data */
    private _idx = _classidx pushBackUnique _class;
    if (_idx >= 0) then {
        _classdata set [_idx, []];
    };
} forEach _classfiles;

/* load class data (CODEs) */
{
    _x params ["_class", "_files"];

    private _newdata = _files apply {
        compile preprocessFileLineNumbers
            format ["features\Custom_Factions\loadouts\%1", _x];
    };

    /* add compiled CODE to all classes that inherit from _class,
     * including itself */
    {
        if (_x iskindOf _class) then {
            private _tmp = _classdata select _forEachIndex;
            { _tmp pushBack _x } forEach _newdata;
            //_classdata set [_forEachIndex, _tmp];
        };
    } forEach _classidx;
} forEach _classfiles;

A3MT_factions_idx = _classidx;
A3MT_factions_data = _classdata;

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
        private _idx = A3MT_factions_idx find typeOf _this;
        if (_idx >= 0) then {
            private _data = A3MT_factions_data select _idx;
            { _this call _x } forEach _data;
        };
    };
};

/* hook event handlers */
{
    ["All", _x, _call_classes] call CBA_fnc_addClassEventHandler;
} forEach ["init", "respawn"];
