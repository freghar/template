/*
 * manually execute user-specified '_files' for a given '_unit'
 *
 * execution order of class-based loadouts vs this function is not
 * guaranteed, one may execute sooner than the other and they may
 * even interleave (!!!)
 */

params ["_unit"];
private _files = [];
if (typeName _this == "ARRAY") then {
    _this deleteAt 0;  /* class name */
    _files = _this;
};

/* catch errors before executing anything */
private _codes = _files apply {
    compile preprocessFileLineNumbers
        format ["features\Custom_Factions\loadouts\%1", _x];
};

0 = [_unit, _codes] spawn {
    params ["_unit", "_codes"];
    { _unit call _x } forEach _codes;
};
