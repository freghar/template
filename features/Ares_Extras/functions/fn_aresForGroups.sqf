/*
 * call '_code' for each Curator-selected group, passing the group as arg,
 * the execution is guaranteed to run only where each group is local
 *
 * - if Ares marker is placed directly on a unit, use its group
 * - if it is placed on empty ground, wait a few seconds to let the Curator
 *   select groups with mouse
 */

params ["_code", "_ares_args"];
_ares_args params ["_pos", "_unit"];

/* unit selected, use its group */
if (!isNil "_unit" && !isNull _unit) then {
    private _group = group _unit;
    [_group, _code] remoteExec ["BIS_fnc_call", groupOwner _group];

/* placed on empty ground, wait for group selection */
} else {
    0 = [_code] spawn {
        params ["_code"];
        private _groups = [];

        ["Select groups with mouse."] call Ares_fnc_ShowZeusMessage;

        /* 20*0.5 = 10 seconds */
        for "_x" from 1 to 20 do {
            _groups = (curatorSelected select 1);
            if (count _groups > 0) exitWith {};
            sleep 0.5;
        };

        [
            format ["Selected %1 groups.", count _groups]
        ] call Ares_fnc_ShowZeusMessage;

        if (count _groups == 0) exitWith {};

        {
            [_x, _code] remoteExec ["BIS_fnc_call", groupOwner _x];
        } forEach _groups;
    };
};
