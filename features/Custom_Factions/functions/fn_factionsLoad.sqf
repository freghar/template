/*
 * adds init and respawn CBA XEHs to load the gear
 */

/*
 * Algorithm:
 * The obvious way would be to simply walk the classes.txt line-by-line and
 * calling the code if the classname matches. Since SQF is abysmally slow when
 * iterating, this can be really slow for larger classes.txt (100s of lines).
 *
 * However any other approach doesn't guarantee execution flow - ie. if we were
 * to walk BIS_fnc_returnParents and execute files from the oldest parent, it
 * would get us inheritance exec order, not class.txt order.
 *
 * The other extreme case is to walk classes.txt, iterating configClasses (cmd)
 * and adding the pre-processed files (CODE) into each matching class. There are
 * approx. 10000 of classes though, eating lots of memory, but also taking ~15ms
 * per class during preInit, resulting in about 150sec delay.
 * The runtime cost would be very low though, as each class would know exactly
 * which CODEs to run, without searching the list and matching classnames.
 *
 * We take the middle road - we do the "slow" classes.txt walk for each class
 * only once and then remember (cache) the result, simply executing the cached
 * result for a given class next time, with virtually zero overhead.
 * This allows us to cache only classes which are actually used in the mission
 * while (almost) getting the speed benefit as if we pre-cached everything.
 */

#include "..\..\..\userconfig.h"

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
 *   ["classname", <CODE>]      -> ["classname", false, [<CODE>]]
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
        if (typeName _x != "CODE") then {
            compile preprocessFileLineNumbers
                format ["features\Custom_Factions\loadouts\%1", _x];
        } else {
            _x
        };
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
        if (!local _this) exitWith {};
#ifdef FEAT_ARSENAL_RESPAWN
        /* no way to detect if player uses arsenal or not, so disable
         * faction-based loadout for all players, assume all use it */
        /* _this is always non-null, but player may be */
        if (!isDedicated) then { waitUntil { !isNull player } };
        if (_this == player) exitWith {};
#endif
        { _this call _x } forEach (_this call A3MT_fnc_factionsGetCodes);
    };
};

/* hook event handlers */
{
    ["All", _x, _call_classes] call CBA_fnc_addClassEventHandler;
} forEach ["init", "respawn"];
