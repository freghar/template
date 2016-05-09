/*
 * manually execute user-specified '_files' for a given '_unit'
 *
 * execution order of class-based loadouts vs this function is not
 * guaranteed, one may execute sooner than the other and they may
 * even interleave (!!!)
 *
 * use fn_factionsAppend if you need to add per-unit customizations
 * to class-based loadouts
 *
 * examples:
 *   "file.sqf" call A3MT_fnc_factionsExec;                  //on init line
 *   ["file1.sqf", "file2.sqf"] call A3MT_fnc_factionsExec;  //on init line
 *   [_unit, "file.sqf] call A3MT_fnc_factionsExec;          //anywhere
 */

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
    { _unit call _x } forEach _codes;
};
