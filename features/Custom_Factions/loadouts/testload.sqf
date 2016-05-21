comment "Exported from Arsenal by Freghar";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "U_C_Driver_1";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "16Rnd_9x21_Mag";
_this addVest "V_PlateCarrierSpec_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
_this addItemToVest "SmokeShell";
_this addItemToVest "SmokeShellGreen";
_this addItemToVest "SmokeShellOrange";
_this addItemToVest "SmokeShellPurple";
for "_i" from 1 to 2 do {_this addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
_this addBackpack "I_UAV_01_backpack_F";
_this addHeadgear "H_RacingHelmet_1_red_F";
_this addGoggles "G_Bandanna_blk";

comment "Add weapons";
_this addWeapon "LMG_Zafir_F";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_ACO_grn";
_this addWeapon "launch_I_Titan_short_F";
_this addWeapon "hgun_P07_F";
_this addHandgunItem "muzzle_snds_L";
_this addWeapon "Rangefinder";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemGPS";
_this linkItem "NVGoggles_INDEP";

comment "Set identity";
_this setFace "WhiteHead_04";
_this setSpeaker "Male06ENG";
[_this,"GryffinRegiment"] call bis_fnc_setUnitInsignia;
