/*
 * call '_code' for each Curator-selected unit, passing the unit as arg
 *
 * the execution is guaranteed to run only on the server
 */

params ["_code", "_ares_args"];

[
    [
        _code,
        {
            params ["_code", "_units"];
            {
                [_x, _code] remoteExec ["BIS_fnc_call", 2];
            } forEach _units;
        }
    ],
    _ares_args
] call A3MT_fnc_aresSelection;
