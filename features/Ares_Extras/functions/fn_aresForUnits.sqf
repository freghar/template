/*
 * call '_code' for each Curator-selected unit, passing the unit as arg
 * the execution is guaranteed to run only where each unit is local
 *
 * - if Ares marker is placed directly on a unit, use it alone
 * - if it is placed on empty ground, wait a few seconds to let the Curator
 *   select units with mouse
 */

params ["_code", "_ares_args"];
_ares_args params ["_pos", "_unit"];

/* unit selected, use just it */
if (!isNil "_unit" && !isNull _unit) then {
    [_unit, _code] remoteExec ["BIS_fnc_call", _unit];

/* placed on empty ground, wait for unit selection */
} else {
    0 = [_code] spawn {
        params ["_code"];
        private _units = [];

        ["Select units with mouse."] call Ares_fnc_ShowZeusMessage;

        /* 20*0.5 = 10 seconds */
        for "_x" from 1 to 20 do {
            _units = (curatorSelected select 0);
            if (count _units > 0) exitWith {};
            sleep 0.5;
        };

        [
            format ["Selected %1 units.", count _units]
        ] call Ares_fnc_ShowZeusMessage;

        if (count _units == 0) exitWith {};

        {
            [_x, _code] remoteExec ["BIS_fnc_call", _x];
        } forEach _units;
    };
};
