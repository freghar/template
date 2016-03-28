/*
 * make '_unit's group flee
 */

params ["_pos", "_unit"];

if (isNull _unit) then {
    ["Place on a unit."] call Ares_fnc_ShowZeusMessage;
} else {
    [
        {(group _this) allowFleeing 1}, _unit, false
    ] call Ares_fnc_BroadcastCode;
};
