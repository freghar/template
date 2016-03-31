/*
 * loads a gear for '_unit' from the filesystem based on '_unit' class name
 * if a gear file doesn't exist it doesn't do anything
 * files are being looked in features\Custom_Factions\loadouts\ folder
 *
 * for example - a blufor medic has a class name B_medic_F
 * a script file name should then be called b_medic_f.sqf and placed in the
 * features\Custom_Factions\loadouts\ folder as mentioned above
 *
 * IMPORTANT!
 * after arsenal export, replace 'this' with '_this' in the loadout script
 */

params ["_unit"];
private ["_className","_fileName","_handle"];

_className = toLower(typeOf _unit);

if (isNil "A3MT_custom_gear") then {
    A3MT_custom_gear = []; // gracefully exit with error
    diag_log "features\Custom_Factions\loadouts\loadouts.sqf was not properly defined";
};

if (_className in A3MT_custom_gear) then {
    _fileName = format ["features\Custom_Factions\loadouts\%1.sqf", _className];
    _handle = _unit execVM _fileName;
};
