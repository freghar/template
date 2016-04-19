/*
 * when placed on an object, specified by '_this', serve as a very limited
 * imitation of the Arsenal save/load functionality
 *
 * allow one loadout save (for a player) per mission (or per JIP) with each
 * respawn activating a load/restore option for a limited time
 * - both save and restore are Actions placed on '_this' object, so a player
 *   has to be near it to perform either
 *
 * this function can be used on multiple objects, but the save/restore state
 * is kept separately and will be synchronized between objects
 */

private _dosave = {
    A3MT_gearkeeper_inv = getUnitLoadout player;

    player addEventHandler ["Respawn", {
        A3MT_gearkeeper_canload = 1;

        /* in case player respawns multiple times within the timer */
        if (!isNil "A3MT_gearkeeper_timer" && !isNull A3MT_gearkeeper_timer) then {
            terminate A3MT_gearkeeper_timer;
        };

        A3MT_gearkeeper_timer = [] spawn {
            sleep 300;  /* 5 min to restore gear after respawn */
            A3MT_gearkeeper_canload = nil;
        };
    }];
};

private _doload = {
    A3MT_gearkeeper_canload = nil;
    player setUnitLoadout A3MT_gearkeeper_inv;
};

_this addAction [
    "Save gear",
    _dosave,
    nil,
    0.1, false, true, "",
    "(_target distance _this) < 3 && isNil ""A3MT_gearkeeper_inv"""
];
_this addAction [
    "Restore gear",
    _doload,
    nil,
    0.1, false, true, "",
    "(_target distance _this) < 3 && !isNil ""A3MT_gearkeeper_canload"""
];
