0 = _this spawn { sleep 1;  // override mod-based init EH

clearWeaponCargoGlobal _this;
clearMagazineCargoGlobal _this;
clearBackpackCargoGlobal _this;
clearItemCargoGlobal _this;

_this addItemCargoGlobal ["ACE_fieldDressing", floor random [0, 2, 8]];
_this addItemCargoGlobal ["ACE_morphine", floor random [0, 1, 4]];

if (random 100 < 1) then { _this addItemCargoGlobal ["ItemGPS", 1] };
if (random 20 < 1) then { _this addItemCargoGlobal ["SmokeShell", floor random 4] };
if (random 10 < 1) then { _this addItemCargoGlobal ["ACE_CableTie", floor random 5] };
if (random 10 < 1) then {
    _this addItemCargoGlobal ["ACE_MapTools", 1];
    _this addItemCargoGlobal ["ItemMap", 1];
    _this addItemCargoGlobal ["ItemCompass", floor random 2];
};

};
