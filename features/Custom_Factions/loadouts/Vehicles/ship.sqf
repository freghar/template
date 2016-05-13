0 = _this spawn { sleep 1;  // override mod-based init EH

clearWeaponCargoGlobal _this;
clearMagazineCargoGlobal _this;
clearBackpackCargoGlobal _this;
clearItemCargoGlobal _this;

_this addItemCargoGlobal ["ACE_fieldDressing", floor random [4, 8, 12]];
_this addItemCargoGlobal ["ACE_morphine", floor random [2, 4, 6]];

};