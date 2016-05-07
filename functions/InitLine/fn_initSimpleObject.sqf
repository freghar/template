/*
 * when one or more objects are synchronized:
 * - re-create all synchronzied objects as SimpleObjects, using their original
 *   positions, vectors, etc.
 * - optionally, execute custom CODE for each newly created object
 * - example:
 *     call A3MT_fnc_initSimpleObject;
 *     { systemChat str _this } call A3MT_fnc_initSimpleObject;
 *
 * when no objects are synchronized:
 * - create a new SimpleObject with .p3d path specified by a 1st argument
 * - optionally, execute custom CODE (2nd argument) for the object
 * - example:
 *     "a3\path\to\model.p3d" call A3MT_fnc_initSimpleObject;
 *     ["a3\path\to\model.p3d", { systemChat str _this }] call A3MT_fnc_initSimpleObject;
 *
 * The custom CODE part can be used mainly to:
 * - hide certain parts of the model, using the 'hideSelection' command
 * - animate some parts of the model, using the 'animate' command
 *
 * To get list of all selections / animations of a unit into clipboard:
 *   copyToClipboard ("selections: " + str selectionNames _this + toString [13,10,13,10] + "anims: " + str animationNames _this)
 *
 * list of some p3d models (possibly not complete):
 *   https://community.bistudio.com/wiki/createSimpleObject/objects
 */

if (!isServer) exitWith {};

private _unit = this;
private _synced = synchronizedObjects _unit;

if (count _synced > 0) then {
    params [["_code", {}]];
    {
        /* we're doing this before simulation starts, we can thus have easily
         * both objects overlapping each other before we delete the old one */
        private _obj = createSimpleObject [getModelInfo _x select 1,
                                           getPosWorld _x];
        _obj setVectorDirAndUp [vectorDir _x, vectorUp _x];
        _obj call _code;
        deleteVehicle _x;
    } forEach synchronizedObjects _unit;

} else {
    params ["_p3d", ["_code", {}]];
    private _obj = createSimpleObject [_p3d, getPosWorld _unit];
    private _dir = vectorDir _unit;  /* rotation same as Logic unit */
    private _up = surfaceNormal position _unit;
    _obj setVectorDirAndUp [_dir, _up];
    _obj call _code;
};

deleteVehicle _unit;
