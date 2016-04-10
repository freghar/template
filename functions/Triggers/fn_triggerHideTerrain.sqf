/*
 * hide terrain objects in a perfectly circular trigger area, optionally
 * limited by a '_filter', specified as an array of object names
 *
 * uses trigger properties:
 *   position (2D), radius (X only)
 *
 * example:
 *   call A3MT_fnc_triggerHideTerrain;
 *   ["TREE", "BUSH"] call A3MT_fnc_triggerHideTerrain;
 *
 * list of known filter names (strings) is at:
 *   https://community.bistudio.com/wiki/nearestTerrainObjects
 */

if (!isServer) exitWith {};

private _trigger = thisTrigger;
private _filter = [];
if (!isNil "_this") then {
    _filter = _this;
};

(triggerArea _trigger) params ["_rx", "_ry", "_angle", "_rectangle"];

/* nearestTerrainObjects doesn't support ellipsoids or rectangles */
if (!_rectangle && _rx == _ry) then {
    {
        _x hideObjectGlobal true;
    } count nearestTerrainObjects [_trigger, _filter, _rx];
};

deleteVehicle _trigger;
