/* not for server/HC */
if (!hasInterface) exitWith {};

/* local, for every (incl. JIP) player */
_this addAction ["<t color='#ffdb00'>CompM2 Aimpoint</t>", { player addPrimaryWeaponItem "RH_compM2" }];
_this addAction ["<t color='#ffdb00'>T1 Red Dot</t>", { player addPrimaryWeaponItem "RH_t1" }];
_this addAction ["<t color='#ffdb00'>Eotech Holo</t>", { player addPrimaryWeaponItem "RH_eotexps3" }];

/* disabled, to prevent accidental flashlight, etc. removal */
//_this addAction ["<t color='#ff0000'>Remove All Attachments</t>", { removeAllPrimaryWeaponItems player }];