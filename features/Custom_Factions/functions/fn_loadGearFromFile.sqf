/* 
 * loads a gear for '_unit' from the filesystem based on '_unit' class name
 * if a gear file doesn't exist it doesn't do anything
 * files are being looked in folder defined by A3MT_loadouts_path
 */
params ["_unit"];

private ["_className","_fileName","_handle"];
_className = typeOf _unit;

if (isNil "A3MT_loadouts_path") then {
    A3MT_loadouts_path = "loadouts";
};

_fileName = format ["%1\%2.sqf",A3MT_loadouts_path,_className];

if (_fileName call A3MT_fnc_fileExists) then {
    _handle = _unit execVM _fileName;
};
