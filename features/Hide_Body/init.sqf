/*
 * add "Hide Body" to any newly created corpses, incl. crew in vehicles,
 * helping players stay undetected in stealth-oriented missions
 *
 * in ideal world, Arma would support attachTo for corpses, so they could
 * be properly dragged away without using hack-ish solutions to sync every
 * frame over network
 *
 * the 'reveal' below helps to initiate the sinking animation in some cases
 * where it would be delayed otherwise (up to ~30 seconds!)
 */

addMissionEventHandler ["EntityKilled", {
    params ["_corpse", "_killer"];

    if ((typeOf _corpse) isKindOf "CAManBase") then {
        _corpse addAction [
            "<t color='#ffa500'>Hide Body</t>",
            {
                params ["_target", "_caller"];
                hideBody _target;
                (group _caller) reveal _target;
                _caller playActionNow "MedicOther";
            },
            nil,
            0.1,
            true,
            true,
            "",
            "(_target distance _this) < 2"
        ];
    };
}];
