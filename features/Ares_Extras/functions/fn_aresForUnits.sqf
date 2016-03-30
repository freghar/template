/*
 * call '_code' for each Curator-selected unit, passing the unit as arg
 * the execution is guaranteed to run only where each unit is local
 */

params ["_code", "_ares_args"];

[
    [
        {
            params ["_code", "_units"];
            {
                [_x, _code] remoteExec ["BIS_fnc_call", _x];
            } forEach _units;
        },
        _code
    ],
    _ares_args
] call A3MT_fnc_aresSelection;
