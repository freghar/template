/*
 * make '_unit's group immortal
 */

params ["_pos", "_unit"];

if (isNull _unit) then {
    ["Place on a unit."] call Ares_fnc_ShowZeusMessage;
} else {
    private ["_code"];
    _code = { { _x allowDamage true; } count (units (group _this)); };
    [_code, _unit, false] call Ares_fnc_BroadcastCode;
};
