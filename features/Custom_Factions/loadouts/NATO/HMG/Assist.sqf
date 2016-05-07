comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;

comment "Add containers";
_this forceAddUniform "rhs_uniform_cu_ucp";
for "_i" from 1 to 8 do {_this addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_this addItemToUniform "ACE_morphine";};
for "_i" from 1 to 2 do {_this addItemToUniform "9Rnd_45ACP_Mag";};
for "_i" from 1 to 4 do {_this addItemToUniform "SmokeShell";};
_this addVest "rhsusf_iotv_ucp_Teamleader";
_this addItemToVest "ACRE_PRC343";
_this addItemToVest "ACRE_PRC152";
for "_i" from 1 to 10 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";};
for "_i" from 1 to 2 do {_this addItemToVest "MiniGrenade";};
_this addItemToVest "SmokeShellGreen";
_this addItemToVest "SmokeShellBlue";
_this addBackpack "RHS_M2_MiniTripod_Bag";
_this addHeadgear "rhsusf_ach_helmet_headset_ucp";

comment "Add weapons";
_this addWeapon "rhs_weap_m4a1_carryhandle_pmag";
_this addPrimaryWeaponItem "RH_SFM952V";
_this addWeapon "hgun_ACPC2_F";
_this addWeapon "ACE_Vector";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "ItemGPS";