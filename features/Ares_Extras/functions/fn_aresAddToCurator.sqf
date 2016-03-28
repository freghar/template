/*
 * add objects in a user-selected radius around '_pos' to curator
 */

params ["_pos", "_unit"];

private _selected = [
    "Add objects to curator", [
        "Distance from marker", [
            "Within 10m",
            "Within 100m",
            "Within 500m",
            "Within 1000m",
            "Within 5000m"
        ],
        1
    ]
] call Ares_fnc_ShowChooseDialog;

private "_radius";
if (count _selected > 0) then {
    switch (_selected select 0) do {
        case 0: { _radius = 10;   };
        case 1: { _radius = 100;  };
        case 2: { _radius = 500;  };
        case 3: { _radius = 1000; };
        case 4: { _radius = 5000; };
        default { _radius = 1;    };
    };
};

private _toadd = (_pos nearObjects _radius)
               + (_pos nearSupplies _radius);

[_toadd] call Ares_fnc_AddUnitsToCurator;
