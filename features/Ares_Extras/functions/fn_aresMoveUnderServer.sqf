/*
 * move ownership of a group of units under the server (its client instance)
 * - the owner takes care of AI actions and sends updates to others, it makes
 *   more sense to have server do this (NOT default for Zeus-spawned units)
 */

params ["_pos", "_unit"];

if (isNull _unit) then {
    ["Place on a unit."] call Ares_fnc_ShowZeusMessage;
} else {
    [
        { (group _this) setGroupOwner 2; }, _unit, false
    ] call Ares_fnc_BroadcastCode;
};
