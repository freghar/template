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

        [[_pos, _radius], {
            params ["_pos", "_radius"];
            {
                _x hideObjectGlobal true;
            } count nearestTerrainObjects [_pos, [], _radius];
        }] call A3MT_fnc_execServer;
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

        [[_pos, _radius], {
            params ["_pos", "_radius"];
            {
                _x hideObjectGlobal false;
            } count nearestTerrainObjects [_pos, [], _radius];
        }] call A3MT_fnc_execServer;
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
        [[_curator, _toadd], {
            params ["_curator", "_units"];
            _curator addCuratorEditableObjects [_units, true];
        }] call A3MT_fnc_execServer;
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

        private _todel = (_pos nearObjects _radius)
                       + (_pos nearSupplies _radius);

        private _curator = getAssignedCuratorLogic player;
        [[_curator, _todel], {
            params ["_curator", "_units"];
            _curator removeCuratorEditableObjects [_units, true];
        }] call A3MT_fnc_execServer;
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT - Util",
    "[U] Curator - Remove",
    {
        [{
            private _curator = getAssignedCuratorLogic player;
            [[_curator, _this], {
                params ["_curator", "_units"];
                _curator removeCuratorEditableObjects [_units, true];
            }] call A3MT_fnc_execServer;
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
        [{ _this enableSimulationGlobal true }, _this]
            call A3MT_fnc_aresForUnitsServer;
    }
] call Ares_fnc_RegisterCustomModule;
[
    "A3MT - Util",
    "[U] Simulation - Off",
    {
        [{ _this enableSimulationGlobal false }, _this]
            call A3MT_fnc_aresForUnitsServer;
    }
] call Ares_fnc_RegisterCustomModule;

[
    "A3MT - Util",
    "[U] Teleport",
    {
        params ["_pos", "_unit"];
        [[_pos, {
            params ["_pos", "_units"];
            [_units, _pos] call A3MT_fnc_teleport;
        }], _this] call A3MT_fnc_aresSelection;
    }
] call Ares_fnc_RegisterCustomModule;

[
    "A3MT - Util",
    "[G] Transfer To Server",
    {
        [{ _this setGroupOwner 2; }, _this] call A3MT_fnc_aresForGroupsMP;
    }
] call Ares_fnc_RegisterCustomModule;
