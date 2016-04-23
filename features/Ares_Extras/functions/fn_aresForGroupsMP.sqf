/*
 * call '_code' for each Curator-selected group, passing the group as arg
 *
 * the execution is guaranteed to run only where each group is local (default)
 * or where the user specified (object, ClientID or 0, like remoteExec)
 */

params ["_code", "_ares_args", "_clientid"];

[
    [
        _code,
        {
            params ["_code", "_groups"];
            {
                private _where = _x;
                if (!isNil "_clientid") then {
                    _where = _clientid;
                };

                if (typeName _code == "ARRAY") then {
                    [[(_code select 0), _x], (_code select 1)]
                        remoteExec ["BIS_fnc_call", _where];
                } else {
                    [_x, _code] remoteExec ["BIS_fnc_call", _where];
                };
            } forEach _groups;
        }
    ],
    _ares_args,
    true
] call A3MT_fnc_aresSelection;
