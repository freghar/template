/*
 * makes '_unit' without primary weapon '_holster' (bool) its pistol
 *
 * useful for cops scenarios
 */

params ["_unit", ["_holster", true]];

if (_holster) then {
    _unit action ["SwitchWeapon", _unit, _unit, -1];
} else {
    /* works, but not reliably - use HandGunOn instead */
    //_unit action ["SwitchWeapon", _unit, _unit, 0];
    _unit action ["HandGunOn", _unit];
};
