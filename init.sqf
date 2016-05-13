#include "features\init.sqf"

// ACRE2: disables building occlusion
ACRE_TEST_OCCLUSION = false;
[0.2] call acre_api_fnc_setLossModelScale;

// move editor-placed units under headless client(s)
if (isServer) then {
    /* find all units named "HC_0", "HC_1", .. up to 16 */
    private _hcs = [];
    for "_x" from 0 to 16 do {
        private _name = format ["HC_%1", _x];
        if (!isNil _name) then {
            _hcs pushBack (call compile _name);
        };
    };
    /* no HCs? */
    if (count _hcs < 1) exitWith {};
    0 = _hcs spawn {
        /* wait for all HCs to be initialized */
        waitUntil { !(0 in (_this apply { owner _x })) };
        private _owners = _this apply { owner _x };
        /* do simple round-robin distribution */
        private _next = 0;
        {
            //diag_log format ["ABUK: group %1 owner %2, setting %3",
            //    str _x, str groupOwner _x, str (_owners select _next)];
            if (groupOwner _x <= 2) then {
                _x setGroupOwner (_owners select _next);
                _next = ((_next + 1) % count _owners);
            };
        } forEach allGroups;
    };
};

// nice location text display, after all initialization
0 = [] spawn {
    waitUntil { time > 0 };
    sleep 20;
    "Template (test)" call A3MT_fnc_instaOSD;
};