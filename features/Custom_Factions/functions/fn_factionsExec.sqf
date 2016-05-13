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
 *   [_unit, "file.sqf", { some code }] call A3MT_fnc_factionsExec;
 */

/* compatibility with unit init line - omit the explicit _unit */
private _unit = (_this select 0);
_this deleteAt 0;

/* catch errors before executing anything */
private _codes = _this apply {
    if (typeName _x != "CODE") then {
        compile preprocessFileLineNumbers
            format ["features\Custom_Factions\loadouts\%1", _x];
    } else {
        _x
    };
};

{ _unit call _x } forEach _codes;
