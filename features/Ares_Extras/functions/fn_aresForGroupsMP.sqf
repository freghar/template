/*
 * call '_code' for each Curator-selected group, passing the group as arg,
 *
 * the execution is guaranteed to run only where each group is local
 */

params ["_code", "_ares_args"];

[
    [
        _code,
        {
            params ["_code", "_groups"];
            {
                if (typeName _code == "ARRAY") then {
                    [[(_code select 0), _x], (_code select 1)]
                        remoteExec ["BIS_fnc_call", _x];
                } else {
                    [_x, _code] remoteExec ["BIS_fnc_call", _x];
                };
            } forEach _groups;
        }
    ],
    _ares_args,
    true
] call A3MT_fnc_aresSelection;
