/*
 * hide terrain objects in a perfectly circular trigger area, with trigger
 * being defined by a 'thisTrigger' global variable (not passed),
 * optionally limited by a '_filter', specified as an array of object names
 *
 * use in 'On Activation' trigger field as ie.
 *   call A3MT_fnc_triggerHideTerrain;
 *   ["tree", "bush"] call A3MT_fnc_triggerHideTerrain;
 *
 * list of known filter names (strings), full list unknown:
 *   bunker, bush, busstop, chapel, church, command, cross, fence, fortress,
 *   fuelstation, hospital, house, lighthouse, power, powerwave, powerwind,
 *   rock, ruin, shipwreck, smalltree, stack, tourism, transmitter, tree,
 *   viewtower, wall
 */

private _trigger = thisTrigger;
private _filter = [];
if (!isNil "_this") then {
    _filter = _this;
};

(triggerArea _trigger) params ["_rx", "_ry", "_angle", "_rectangle"];

/* don't do anything
 * - if the trigger is a rectangle
 * - if the trigger isn't perfectly round
 * as nearestTerrainObjects doesn't allow us to do any of these */
if (_rectangle || _rx != _ry) exitWith {};

{
    /* no need for hideObjectGlobal, all clients (incl. JIP) will have
     * the trigger as well if it's defined in a mission file */
    _x hideObject true;
} count nearestTerrainObjects [_trigger, _filter, _rx];
