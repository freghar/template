comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;

comment "Add containers";
_this forceAddUniform "U_BG_Guerrilla_6_1";
for "_i" from 1 to 8 do {_this addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_this addItemToUniform "ACE_morphine";};
for "_i" from 1 to 2 do {_this addItemToUniform "9Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "SmokeShell";};
_this addVest "TacVest_black";
_this addItemToVest "ACRE_PRC343";
for "_i" from 1 to 5 do {_this addItemToVest "30Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToVest "MiniGrenade";};
_this addItemToVest "SmokeShellGreen";
_this addItemToVest "SmokeShellBlue";
_this addHeadgear "H_HelmetCrew_I";

comment "Add weapons";
_this addWeapon "SMG_02_F";
_this addWeapon "hgun_ACPC2_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "ItemGPS";
_this linkItem "ACE_NVG_Wide";