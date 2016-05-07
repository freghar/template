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
_this addVest "rhsusf_iotv_ucp_SAW";
_this addItemToVest "ACRE_PRC343";
for "_i" from 1 to 2 do {_this addItemToVest "hlc_100Rnd_762x51_M_M60E4";};
_this addItemToVest "hlc_100Rnd_762x51_T_M60E4";
for "_i" from 1 to 2 do {_this addItemToVest "MiniGrenade";};
_this addBackpack "B_AssaultPack_rgr";
_this addItemToBackpack "ACE_SpareBarrel";
for "_i" from 1 to 3 do {_this addItemToBackpack "hlc_100Rnd_762x51_M_M60E4";};
_this addItemToBackpack "hlc_100Rnd_762x51_T_M60E4";
_this addHeadgear "rhsusf_ach_helmet_ESS_ucp";

comment "Add weapons";
_this addWeapon "hlc_lmg_m60";
_this addWeapon "hgun_ACPC2_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";