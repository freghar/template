/*
 * call '_code' for each Curator-selected group, passing the group as arg,
 *
 * the execution is guaranteed to run only on the server
 */

params ["_code", "_ares_args"];

[
    [
        _code,
        {
            params ["_code", "_groups"];
            {
                [_x, _code] remoteExec ["BIS_fnc_call", 2];
            } forEach _groups;
        }
    ],
    _ares_args,
    true
] call A3MT_fnc_aresSelection;
