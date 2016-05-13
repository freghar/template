if (!isServer) exitWith {};

clearWeaponCargoGlobal _this;
clearMagazineCargoGlobal _this;
clearBackpackCargoGlobal _this;
clearItemCargoGlobal _this;

_this addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag", 80];
_this addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 20];
_this addMagazineCargoGlobal ["SmokeShell", 30];
_this addMagazineCargoGlobal ["SmokeShellGreen", 8];
_this addMagazineCargoGlobal ["SmokeShellBlue", 4];
_this addMagazineCargoGlobal ["MiniGrenade", 24];
_this addMagazineCargoGlobal ["rhs_mag_M441_HE", 15];
_this addMagazineCargoGlobal ["rhsusf_100Rnd_556x45_soft_pouch", 12];
_this addMagazineCargoGlobal ["hlc_100Rnd_762x51_M_M60E4", 4];
_this addWeaponCargoGlobal   ["tf47_at4_HEDP", 4];
_this addMagazineCargoGlobal ["tf47_m3maaws_HEAT", 4];
_this addMagazineCargoGlobal ["tf47_m3maaws_HEDP", 2];

_this addItemCargoGlobal ["ACE_fieldDressing", 40];
_this addItemCargoGlobal ["ACE_morphine", 20];
_this addItemCargoGlobal ["ACE_epinephrine", 10];
_this addItemCargoGlobal ["ACE_bloodIV", 4];
