/*
 * given a unit as '_this', return an array of CODE blocks to execute for it
 *
 * note: this is an internal function, don't use it in your mission
 *
 * see fn_factionsLoad for description of the global vars
 */

/* try fast cache lookup first */
private _idx = A3MT_factions_idx find typeOf _this;
if (_idx >= 0) exitWith {
    A3MT_factions_data select _idx;
};

/* class not in cache, iterate full CODE list */
private _cached = [];
{
    _x params ["_class", "_inherit", "_codes"];
    if (_inherit) then {
        if (_this isKindOf _class) then {
            { _cached pushBack _x } forEach _codes;
        };
    } else {
        if (typeOf _this == _class) then {
            { _cached pushBack _x } forEach _codes;
        };
    };
} forEach A3MT_factions_classcodes;

/* add matching CODEs to cache, watch for race conditions
 * - pushBackUnique returns -1 if another piece of code was faster */
private _idx = A3MT_factions_idx pushBackUnique typeOf _this;
if (_idx >= 0) then {
    A3MT_factions_data set [_idx, _cached];
};

_cached;
