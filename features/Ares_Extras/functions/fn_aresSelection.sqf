/*
 * call '_code' for a Curator-selected object or group of objects, passing them
 * as argument (array in all cases, even when 1 object is selected)
 *
 * - if Ares marker is placed directly on an object, use it
 * - if it is placed on empty ground, wait a few seconds to let the Curator
 *   select multiple objects with mouse
 *
 * '_gfilter' is a boolean
 * - true: return an array of selected (unique) groups only
 * - false (default): return an array of selected units
 *
 * the passed array may be empty if Curator didn't select any objects
 *
 * if '_code' is an ARRAY (not CODE), its first member should be CODE and the
 * second member is passed as a first argument to the code, with array of
 * objects from this function being passed as second
 */

params ["_code", "_ares_args", ["_gfilter", false]];
_ares_args params ["_pos", "_unit"];

/* object selected as Ares _unit, use it */
if (!isNil "_unit" && !isNull _unit) then {
    if (!_gfilter) then {
        if (typeName _code == "ARRAY") then {
            [(_code select 1), [_unit]] call (_code select 0);
        } else {
            [_unit] call _code;
        };
    } else {
        if (typeName _code == "ARRAY") then {
            [(_code select 1), [group _unit]] call (_code select 0);
        } else {
            [group _unit] call _code;
        };
    };

/* placed on empty ground, wait for mouse selection */
} else {
    0 = [_code, _gfilter] spawn {
        params ["_code", "_gfilter"];

        ["Select objects with mouse."] call Ares_fnc_ShowZeusMessage;

        /* 20*0.5 = 10 seconds */
        private ["_objects"];
        for "_x" from 1 to 20 do {
            _objects = (curatorSelected select ([0,1] select _gfilter));
            if (count _objects > 0) exitWith {};
            sleep 0.5;
        };

        [
            format ["Selected %1 objects.", count _objects]
        ] call Ares_fnc_ShowZeusMessage;

        if (typeName _code == "ARRAY") then {
            [(_code select 1), _objects] call (_code select 0);
        } else {
            _objects call _code;
        };
    };
};
