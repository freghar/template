/*
 * this is a loadout example for b_soldier_f class (blufor rifleman)
 * note how default Arsenal export has been modified with this => _this
 *
 * warning - example is dependent on RHS mod
 */

removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "rhs_uniform_cu_ocp_101st";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "rhs_mag_30Rnd_556x45_Mk318_Stanag";};
_this addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";
_this addVest "V_PlateCarrier1_rgr";
_this addItemToVest "SmokeShell";
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_this addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_this addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
_this addHeadgear "H_HelmetB";
_this addGoggles "rhs_googles_yellow";

comment "Add weapons";
_this addWeapon "rhs_weap_m4a1";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_Aco";
_this addWeapon "rhsusf_weap_glock17g4";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";
_this linkItem "NVGoggles";
