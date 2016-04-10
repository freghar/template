/*
 * spawn a cylindrical object (considered "house") that absorbs any bullets
 * and explosions made inside it and blocks these from the outside, while
 * allowing units to move freely trough it
 *
 * optionally set a '_color' for it (with alpha) as an array of [r,g,b,a],
 * will be visible only from the outside
 *
 * uses trigger properties:
 *   position
 *
 * example:
 *   call A3MT_fnc_triggerSafeArea;
 *   [0,1,0,0.1] call A3MT_fnc_triggerSafeArea;
 */

if (!isServer) exitWith {};

private _trigger = thisTrigger;
private _color = _this;

private _obj = "ProtectionZone_Ep1" createVehicle (position _trigger);

/* default is strong red, change it to completely transparent */
private _texture = "#(argb,8,8,3)color(0,0,0,0)";
if (!isNil "_color") then {
    _color params ["_r", "_g", "_b", "_a"];
    _texture = format ["#(argb,8,8,3)color(%1,%2,%3,%4)", _r,_g,_b,_a];
};
_obj setObjectTextureGlobal [0, _texture];

deleteVehicle _trigger;
