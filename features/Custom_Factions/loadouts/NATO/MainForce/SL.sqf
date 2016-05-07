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
_this addVest "rhsusf_iotv_ucp_Squadleader";
for "_i" from 1 to 2 do {_this addItemToVest "ACE_CableTie";};
_this addItemToVest "ACE_MapTools";
_this addItemToVest "ACRE_PRC343";
_this addItemToVest "ACRE_PRC152";
for "_i" from 1 to 10 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";};
_this addBackpack "B_AssaultPack_rgr";
for "_i" from 1 to 5 do {_this addItemToBackpack "rhs_mag_m714_White";};
for "_i" from 1 to 5 do {_this addItemToBackpack "rhs_mag_m713_Red";};
for "_i" from 1 to 2 do {_this addItemToBackpack "MiniGrenade";};
for "_i" from 1 to 3 do {_this addItemToBackpack "SmokeShell";};
for "_i" from 1 to 5 do {_this addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellBlue";};
_this addHeadgear "rhsusf_ach_helmet_headset_ucp";

comment "Add weapons";
_this addWeapon "rhs_weap_m16a4_carryhandle_M203";
_this addPrimaryWeaponItem "RH_SFM952V";
_this addWeapon "hgun_ACPC2_F";
_this addWeapon "ACE_Vector";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "ItemGPS";

sleep 10;
removeHeadgear _this;
sleep 10;
