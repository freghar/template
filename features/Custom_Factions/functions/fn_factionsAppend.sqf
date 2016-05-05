/*
 * manually execute user-specified '_files' for a given '_unit' now and after
 * each respawn of the '_unit'
 *
 * this function is meant to be used ONLY on units affected by class-based
 * loadouts, see factionsExec for others
 *
 * the '_files' are ALWAYS executed AFTER any class-based loadout code, hence
 * the 'Append' in function name - note however, that repeated calls of this
 * function do nothing - you can only append one set of files, once, for each
 * unit
 *
 * to not add overhead to the more generic case of units without per-unit
 * customization, this function should be called ONLY on the client the '_unit'
 * last respawned on or was created on (is local && faction loadouts were run),
 * typically from a unit init line, otherwise the per-unit loadout will be
 * loaded on next respawn
 *
 * use this function to ie. add per-unit additions to units with loadout
 * otherwise controlled by the class-based loadout script
 *
 * examples:
 *   "file.sqf" call A3MT_fnc_factionsAppend;                  //on init line
 *   ["file1.sqf", "file2.sqf"] call A3MT_fnc_factionsAppend;  //on init line
 *   [_unit, "file.sqf] call A3MT_fnc_factionsAppend;          //anywhere
 */

#include "..\..\..\userconfig.h"

/* compatibility with unit init line - omit the explicit _unit */
private "_unit";
if (!isNil "this") then {
    _unit = this;
} else {
    _unit = (_this select 0);
    _this deleteAt 0;
};
if (!local _unit) exitWith {};

/* allow both single-file string and multi-file array */
private "_files";
if (typeName _this == "ARRAY") then {
    _files = _this;
} else {
    _files = [_this];
};

/* sanity check (see below) triggered when player JIPs into existing
 * AI unit, without respawn - the CODEs have been hooked into class-based
 * loadout script and are already being executed on respawn */
private _unit_codes = _unit getVariable "A3MT_factionsPerUnitCodes";
if (!isNil "_unit_codes") exitWith {};

/* to guarantee execution order on unit init *and* respawn, we need to somehow
 * detect, from class-based loading script, if the unit has defined init line
 * adding per-unit gear - this, however, is not possible as we cannot possibly
 * query the unit init line (and even if we could, the mere presence of a func
 * name inside it wouldn't guarantee a per-unit loadout)
 *
 * what is possible, though, is to do it the other way around - to detect, from
 * the per-unit loadout, if the unit is going to have per-class loadout applied
 * regardless of whether that's yet to happen, is happening or has happened
 * - when we detect that, we can simply export "class-based loading is done"
 *   from the class loading script and wait for this in the per-unit loadout one
 *   (this one you're reading now)
 *
 * this works well for init, but not for respawn where the "is done" flag
 * becomes stale - we therefore use a dual approach
 * in addition to the above, we also store the executed per-unit CODEs into
 * a per-unit variable and check for it in the class-based loadout, which runs
 * on respawn and if the variable is non-nil, we execute its contents
 * - this Exec per-unit function thus does not run on respawn and does not clash
 *   with the class-based loading
 *   - the first execution has to run here, though, as the class-based loadout
 *     has already finished executing (and we cannot wait there as we cannot
 *     check if the unit has per-unit loadout specified / no init line access)
 *
 * note that the per-unit CODES have to be public - transferred to all clients,
 * this is because the unit can change locality at any time (player disconnects,
 * player JIPs into existing AI, etc.) and hooking a "Local" EH, transferring
 * the variable just between src/dst, is too late
 * - not doing this will result in duplicate execution of this script on JIP due
 *   to the new client thinking the per-unit loadout wasn't loaded (or figuring
 *   out that it was thanks to the state variable, but with empty array of CODEs)
 */

/* catch errors before executing anything */
private _codes = _files apply {
    if (typeName _x != "CODE") then {
        compile preprocessFileLineNumbers
            format ["features\Custom_Factions\loadouts\%1", _x];
    } else {
        _x
    };
};

0 = [_unit, _codes] spawn {
    params ["_unit", "_codes"];

#ifdef FEAT_ARSENAL_RESPAWN
    /* see fn_factionsLoad for details */
    if (!isDedicated) then { waitUntil { !isNull player } };
    if (_unit == player) exitWith {};
#endif

    /* wait for class-based loadout loading to finish */
    waitUntil {
        if (isNull _unit) exitWith { true };
        _unit getVariable "A3MT_factionsLoaded";
    };

    if (!isNull _unit) then {
        { _unit call _x } forEach _codes;

        /* executed by factionsLoad / _call_classes next time, on respawn */
        _unit setVariable ["A3MT_factionsPerUnitCodes", _codes, true];
    };
};
