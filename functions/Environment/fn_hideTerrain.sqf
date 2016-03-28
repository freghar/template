/*
 * alter visibility ('_hidden' = true/false) of terrain objects '_radius' meters
 * around a source '_src' object
 */

params ["_hidden", "_src", "_radius"];

{
    _x hideObjectGlobal _hidden;
} count nearestTerrainObjects [_src, [], _radius];
