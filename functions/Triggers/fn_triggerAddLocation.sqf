/*
 * create a Location based on trigger details, specifying class '_type'
 * explicitly via an argument
 *
 * also export trigger text, filtered to [a-zA-Z0-9_], as a global variable
 * for easy references with the "in" operator from scripts
 *
 * uses trigger properties:
 *   position, size (X,Y), orientation, shape, text
 *
 * example:
 *   "NameVillage" call A3MT_fnc_triggerAddLocation;
 *
 * for location types, see:
 *   https://community.bistudio.com/wiki/Location#Location_Types
 */

if (!isServer) exitWith {};

private _trigger = thisTrigger;
private _type = _this;

/* completely decouple details from the trigger object as - by the time client
 * gets to parsing the details - the object might have been already
 * deleteVehicle'd by the server */
(triggerArea _trigger) params ["_sizex", "_sizey", "_orient", "_rect"];
[
    [_type, (position _trigger), _sizex, _sizey, _orient, _rect, triggerText _trigger],
    {
        params ["_type", "_pos", "_sizex", "_sizey", "_orient", "_rect", "_text"];

        private _loc = createLocation [_type, _pos, _sizex, _sizey];
        _loc setText _text;
        _loc setName _text;  /* ?? any use? */
        _loc setRectangular _rect;
        _loc setDirection _orient;

        /* too bad vehicleVarName doesn't work on triggers :( */
        private _varname = [_text] call BIS_fnc_filterString;
        if (_varname != "") then {
            missionNamespace setVariable [_varname, _loc];
        };
    }
] remoteExec ["BIS_fnc_call", 0, true];

deleteVehicle _trigger;
