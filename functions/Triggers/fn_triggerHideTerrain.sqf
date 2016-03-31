/*
 * hide terrain objects in a perfectly circular '_trigger' area,
 * optionally limited by a '_filter', specified as an array of object names
 *
 * use in 'On Activation' trigger field as ie.
 *   thisTrigger call A3MT_fnc_triggerHideTerrain;
 *   [thisTrigger, ["obj1", "obj2"]] call A3MT_fnc_triggerHideTerrain;
 *
 * list of known filter names (strings), full list unknown:
 *   bunker, bush, busstop, chapel, church, command, cross, fence, fortress,
 *   fuelstation, hospital, house, lighthouse, power, powerwave, powerwind,
 *   rock, ruin, shipwreck, smalltree, stack, tourism, transmitter, tree,
 *   viewtower, wall
 */

params ["_trigger", ["_filter", [], [[]]]];

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
