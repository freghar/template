Custom Factions feature
=======================

Description
-----------

This feature enables mission makers to create their own factions using Arsenal exports.
Exported loadouts will be applied to units by their class name. For example, if mission
maker places a blufor rifleman with class name B_soldier_F, a file
b_soldier_f.sqf will be used to apply the correct gear. Files MUST be placed in
features\\Custom_Factions\\loadouts\\ folder.

Works within Zeus, 3den, old 2d editor. Works for JIP units and preserves gear on respawn.

Faction generation howto
------------------------

- in userconfig.h file uncomment the line::

  //#define FEAT_CUSTOM_FACTIONS
- for soldiers in faction you want to use

  - prepare the loadout via Arma 3 Arsenal
  - export it using the export Arsenal feature
  - save it to <class name>.sqf file. Class name can be found
    in top right corner of the 2d editor or hovering over the unit in 3d editor
    for example B_soldier_F
  - rename this to _this in entire file (simple search and replace tool in Notepad++ can
    replace it in all files in loadouts folder)
  - place that file to features\\Custom_Factions\\loadouts\\ folder
  - in the features\\Custom_Factions\\loadouts\\loadouts.sqf add a class name to array
    of classes that call A3MT_fnc_registerGear::

        ["B_soldier_F", "B_soldier_M_F", ...] call A3MT_fnc_registerGear;

  - now whenever you place a unit of class B_soldier_F in 2d/3d editor, it will
    have the correct loadout

Two sample classes with preconfigured loadouts.sqf is provided in the example.
