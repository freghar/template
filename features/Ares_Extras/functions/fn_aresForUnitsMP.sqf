/*
 * call '_code' for each Curator-selected unit, passing the unit as arg
 *
 * the execution is guaranteed to run only where each unit is local
 */

params ["_code", "_ares_args"];

[
    [
        _code,
        {
            params ["_code", "_units"];
            {
                if (typeName _code == "ARRAY") then {
                    [[(_code select 0), _x], (_code select 1)]
                        remoteExec ["BIS_fnc_call", _x];
                } else {
                    [_x, _code] remoteExec ["BIS_fnc_call", _x];
                };
            } forEach _units;
        }
    ],
    _ares_args
] call A3MT_fnc_aresSelection;
