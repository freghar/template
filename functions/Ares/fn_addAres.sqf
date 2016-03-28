/*
 * register custom modules/function in Ares
 */

/*
 * move ownership of a group of units under the server (its client instance)
 * - the owner takes care of AI actions and sends updates to others, it makes
 *   more sense to have server do this (NOT default for Zeus-spawned units)
 */
[
    "A3MT",
    "Move group under server",
    {
        params ["_pos", "_unit"];

        if (isNull _unit) then {
            ["Place on a unit."] call Ares_fnc_ShowZeusMessage;
        } else {
            [
                { (group _this) setGroupOwner 2; }, _unit, false
            ] call Ares_fnc_BroadcastCode;
        };
    }
] call Ares_fnc_RegisterCustomModule;

/*
 * invulnerability on/off
 */
[
    "A3MT",
    "Toggle group immortal",
    {
        params ["_pos", "_unit"];

        if (isNull _unit) then {
            ["Place on a unit."] call Ares_fnc_ShowZeusMessage;
        } else {
            private ["_code"];
            _code = { { _x allowDamage false; } forEach (units (group _this)); };
            [_code, _unit, false] call Ares_fnc_BroadcastCode;
        };
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT",
    "Toggle group mortal",
    {
        params ["_pos", "_unit"];

        if (isNull _unit) then {
            ["Place on a unit."] call Ares_fnc_ShowZeusMessage;
        } else {
            private ["_code"];
            _code = { { _x allowDamage true; } forEach (units (group _this)); };
            [_code, _unit, false] call Ares_fnc_BroadcastCode;
        };
    }
] call Ares_fnc_RegisterCustomModule;

/*
 * AI fleeing
 */
[
    "A3MT",
    "Make cowards",
    {
        params ["_pos", "_unit"];

        if (isNull _unit) then {
            ["Place on a unit."] call Ares_fnc_ShowZeusMessage;
        } else {
            [
                {(group _this) allowFleeing 1}, _unit, false
            ] call Ares_fnc_BroadcastCode;
        };
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT",
    "Make heroes",
    {
        params ["_pos", "_unit"];

        if (isNull _unit) then {
            ["Place on a unit."] call Ares_fnc_ShowZeusMessage;
        } else {
            [ {(group _this) allowFleeing 0}, _unit, false] call Ares_fnc_BroadcastCode;
        };
    }
] call Ares_fnc_RegisterCustomModule;

/*
 * better than default Ares one - adds dropped weapons/mags/etc.
 */
[
    "A3MT",
    "Add objects to curator",
    {
        params ["_pos", "_unit"];
        private ["_selected", "_radius", "_toadd"];

        _selected = [
            "Add objects to curator", [
                "Distance from marker", [
                  "Within 10m",
                  "Within 100m",
                  "Within 500m",
                  "Within 1000m",
                  "Within 5000m"
                ],
                1
            ]
        ] call Ares_fnc_ShowChooseDialog;

        if (count _selected > 0) then {
            switch (_selected select 0) do {
                case 0: { _radius = 10;   };
                case 1: { _radius = 100;  };
                case 2: { _radius = 500;  };
                case 3: { _radius = 1000; };
                case 4: { _radius = 5000; };
                default { _radius = 1;    };
            };
        };

        _toadd = (_pos nearObjects _radius)
               + (_pos nearSupplies _radius);

        [_toadd] call Ares_fnc_AddUnitsToCurator;
    }
] call Ares_fnc_RegisterCustomModule;
