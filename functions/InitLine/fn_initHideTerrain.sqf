/*
 * hide terrain objects in a perfectly circular area around all trigger objects
 * synchronized to the (logic) unit calling this function,
 * optionally limited by a '_filter', specified as an array of object names
 *
 * this function runs before the game begins to allow hiding terrain objects
 * that would normally collide with other editor-placed objects (ie. cars
 * clipping into to-be-removed buildings)
 *
 * note that the trigger area has to be perfectly circular as
 * nearestTerrainObjects expects a radius, not any custom shape
 *
 * uses trigger properties:
 *   position (2D)
 *
 * example:
 *   call A3MT_fnc_initHideTerrain;
 *   ["TREE", "BUSH"] call A3MT_fnc_initHideTerrain;
 *
 * list of known filter names (strings) is at:
 *   https://community.bistudio.com/wiki/nearestTerrainObjects
 */

if (!isServer) exitWith {};

private _unit = this;
private _filter = [];
if (!isNil "_this") then {
    _filter = _this;
};

{
    (triggerArea _x) params ["_rx", "_ry", "_angle", "_rectangle"];
    /* perfect circle */
    if (!_rectangle && _rx == _ry) then {
        {
            _x hideObjectGlobal true;
        } count nearestTerrainObjects [_x, _filter, _rx];
    };
    deleteVehicle _x;
} forEach synchronizedObjects _unit;

deleteVehicle _unit;
