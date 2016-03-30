/*
 * register custom modules/functions in Ares
 */

/*
 * AI
 */

[
    "A3MT - AI",
    "[G] Fleeing - On",
    {
        [{ _this allowFleeing 1 }, _this] call A3MT_fnc_aresForGroupsMP;
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT - AI",
    "[G] Fleeing - Off",
    {
        [{ _this allowFleeing 0 }, _this] call A3MT_fnc_aresForGroupsMP;
    }
] call Ares_fnc_RegisterCustomModule;

/*
 * Environment
 */

[
    "A3MT - Environment",
    "[P] Terrain Objects - Hide",
    {
        params ["_pos", "_unit"];

        private _radius = [
            "Hide terrain objects",
            "" call A3MT_fnc_aresStdDistances
        ] call A3MT_fnc_aresDialog;

        [true, _pos, _radius] call A3MT_fnc_hideTerrain;
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT - Environment",
    "[P] Terrain Objects - Show",
    {
        params ["_pos", "_unit"];

        private _radius = [
            "Hide terrain objects",
            "" call A3MT_fnc_aresStdDistances
        ] call A3MT_fnc_aresDialog;

        [false, _pos, _radius] call A3MT_fnc_hideTerrain;
    }
] call Ares_fnc_RegisterCustomModule;

/*
 * Util
 */

[
    "A3MT - Util",
    "[P] Curator - Add",
    {
        params ["_pos", "_unit"];

        private _radius = [
            "Add objects to Curator / Zeus",
            "" call A3MT_fnc_aresStdDistances
        ] call A3MT_fnc_aresDialog;

        private _toadd = (_pos nearObjects _radius)
                       + (_pos nearSupplies _radius);

        private _curator = getAssignedCuratorLogic player;
        _curator addCuratorEditableObjects [_toadd, true];
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT - Util",
    "[P] Curator - Remove",
    {
        params ["_pos", "_unit"];

        private _radius = [
            "Remove objects from Curator / Zeus",
            "" call A3MT_fnc_aresStdDistances
        ] call A3MT_fnc_aresDialog;

        private _toadd = (_pos nearObjects _radius)
                       + (_pos nearSupplies _radius);

        private _curator = getAssignedCuratorLogic player;
        _curator removeCuratorEditableObjects [_toadd, true];
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT - Util",
    "[U] Curator - Remove",
    {
        [{
            private _curator = getAssignedCuratorLogic player;
            _curator removeCuratorEditableObjects [_this, true];
        }, _this] call A3MT_fnc_aresSelection;
    }
] call Ares_fnc_RegisterCustomModule;

[
    "A3MT - Util",
    "[U] Immortal - On",
    {
        [{ _this allowDamage false }, _this] call A3MT_fnc_aresForUnitsMP;
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT - Util",
    "[U] Immortal - Off",
    {
        [{ _this allowDamage true }, _this] call A3MT_fnc_aresForUnitsMP;
    }
] call Ares_fnc_RegisterCustomModule;

[
    "A3MT - Util",
    "[U] Simulation - On",
    {
        [{
            [_this, {
                { _x enableSimulationGlobal true } forEach _this;
            }] call A3MT_fnc_execServer;
        }, _this] call A3MT_fnc_aresSelection;
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT - Util",
    "[U] Simulation - Off",
    {
        [{
            [_this, {
                { _x enableSimulationGlobal false } forEach _this;
            }] call A3MT_fnc_execServer;
        }, _this] call A3MT_fnc_aresSelection;
    }
] call Ares_fnc_RegisterCustomModule;

[
    "A3MT - Util",
    "[G] Transfer To Server",
    {
        [{ _this setGroupOwner 2; }, _this] call A3MT_fnc_aresForGroupsMP;
    }
] call Ares_fnc_RegisterCustomModule;
