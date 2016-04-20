/*
 * set '_unit's team color (within group)
 *
 * simple wrapper for unit init lines to avoid spawn/waitUntil there,
 * USES 'this' GLOBAL VARIABLE, NOT USABLE WHERE 'this' IS UNSET
 */

if (didJIP) exitWith {};

0 = [this, _this] spawn {
    params ["_unit", "_color"];
    waitUntil { !isNull player };
    _unit assignTeam _color;
};
