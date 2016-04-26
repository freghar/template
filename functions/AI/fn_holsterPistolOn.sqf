/*
 * makes AI unit without primary weapon holster it's pistol
 * useful for cops scenarios
 * WARNING - AI will not be able to play animations
 * use A3MT_fnc_holsterWeaponOff to re-enable the animations
*/

_this action ["SwitchWeapon", _this, _this, -1];
