if (!isServer) exitWith {};

clearWeaponCargoGlobal _this;
clearMagazineCargoGlobal _this;
clearBackpackCargoGlobal _this;
clearItemCargoGlobal _this;

_this addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag", 24];
_this addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", 6];
_this addMagazineCargoGlobal ["SmokeShell", 12];
_this addMagazineCargoGlobal ["MiniGrenade", 10];
_this addMagazineCargoGlobal ["rhs_mag_M441_HE", 4];
_this addMagazineCargoGlobal ["rhsusf_100Rnd_556x45_soft_pouch", 4];
_this addWeaponCargoGlobal   ["tf47_at4_HEDP", 1];

_this addItemCargoGlobal ["ACE_fieldDressing", 16];
_this addItemCargoGlobal ["ACE_morphine", 6];
