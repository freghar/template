/*
 * hide terrain objects in a perfectly circular '_radius' around a logic unit,
 * optionally limited by a '_filter', specified as an array of object names
 *
 * this function is logic-based to allow placing collidable objects (ie. cars)
 * inside terrain objects that will be hidden - logic init line performs the
 * hiding before simulation / mission start, doing everything safely
 *
 * uses properties:
 *   position (2D)
 *
 * example:
 *   50 call A3MT_fnc_logicHideTerrain;
 *   [50, ["TREE", "BUSH"]] call A3MT_fnc_logicHideTerrain;
 *
 * list of known filter names (strings) is at:
 *   https://community.bistudio.com/wiki/nearestTerrainObjects
 */

if (!isServer) exitWith {};

private _unit = this;
params ["_radius", ["_filter", []]];

{
    _x hideObjectGlobal true;
} count nearestTerrainObjects [_unit, _filter, _radius];

deleteVehicle _unit;
