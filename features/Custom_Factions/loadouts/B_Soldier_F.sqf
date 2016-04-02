comment "Exported from Arsenal by Me";

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
_this forceAddUniform "U_B_CombatUniform_mcam";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "30Rnd_65x39_caseless_mag";};
_this addVest "V_PlateCarrier1_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 4 do {_this addItemToVest "SmokeShell";};

comment "Add weapons";
_this addWeapon "arifle_MX_Black_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";

comment "Set identity";
_this setFace "WhiteHead_20";
_this setSpeaker "Male01PER";
