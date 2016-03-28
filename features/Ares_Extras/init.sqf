/*
 * register custom modules/functions in Ares
 */

private _modules = [
    ["A3MT", "Add objects to curator",  A3MT_fnc_aresAddToCurator],
    ["A3MT", "Turn group into cowards", A3MT_fnc_aresFleeing],
    ["A3MT", "Make group immortal",     A3MT_fnc_aresImmortal],
    ["A3MT", "Make group mortal",       A3MT_fnc_aresMortal],
    ["A3MT", "Move group under server", A3MT_fnc_aresMoveUnderServer]
];

{ _x call Ares_fnc_RegisterCustomModule; } forEach _modules;
