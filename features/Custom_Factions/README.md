Custom Factions
===============

Description
-----------

This feature enables mission makers to create their own factions using Arsenal
exports. Exported loadouts will be applied to units based on their class name.
For example, if a mission maker places a blufor rifleman with class name of
`B_soldier_F`, a file `B_soldier_F.sqf` will be used to apply the correct gear.

Alternatively, any inherited class can be used, ie. `CAManBase.sqf` would load
gear for any soldier on any side.

Files must be placed in the loadouts subfolder folder, see the existing example
inside (and adjust/remove it according to your needs).

This feature should work with any spawning mechanism - Zeus, Editor, various
unit-spawning mods, etc. Also works for JIP and loads gear on respawn.

Loadout creation
----------------

1. prepare the loadout via Arma 3 Arsenal
2. export it to clipboard using the export Arsenal feature - bottom right
   corner - EXPORT
3. paste into notepad and save it as `<classname>.sqf` in the loadouts
   subfolder (which is located right next to this README)
   - class name can be found when hovering over the unit in the Eden editor
     or in the top right corner of the (old) 2D editor
4. rename all occurences of the word `this` to `_this` inside the file, for
   example using a 'search and replace' functionality in notepad (or your
   favorite text editor)
   - some editors like Notepad++ can do this on multiple files at once
5. remove other unwanted saved changes like face/voice or facewear along with
   lines removing player-customized one (`removeGoggles`), leaving only the
   modifications you want to perform
6. add the class name to `classes.txt` inside the loadouts subfolder (see below)
7. all done! .. remember to post-process (`this` to `_this`) any newly inserted
   loadouts or loadout updates

Example classes.txt
-------------------

Specify a comma-separated list of strings as classes, do NOT put comma (,)
after the last string, ie.

    "B_Soldier_F", "B_Soldier_A_F"

or separated with new lines, ie.

    "B_Solider_F",
    "B_Soldier_A_F"

You can put comments (anything starting with `//` will be ignored by the game)
on empty lines to describe the loadout for humans reading this file after you,
ie.

    // NATO Rifleman
    "B_Solider_F",

    // NATO Ammo Bearer
    "B_Soldier_A_F"

All of the examples above use the class names for file names as well, ie.
`B_Soldier_F` is taken as `B_Soldier_F.sqf`. You can override it by specifying
an array, denoted with square brackets instead of just string,

    // NATO Rifleman
    ["B_Soldier_F", "mysoldier.sqf"],

    // NATO Ammo Bearer
    "B_Soldier_A_F"

where `mysoldier.sqf` is a file within the "loadouts" directory.

You can go one step further and create your own (sub-)directory structure within
"loadouts", potentially re-using files for multiple classes!

    // any NATO Rifleman - use the same loadout
    ["B_Soldier_F",      "NATO\any_rifleman.sqf"],
    ["B_Soldier_lite_F", "NATO\any_rifleman.sqf"],
    ["B_Soldier_LAT_F",  "NATO\any_rifleman.sqf"]

(again, watch the last comma (,) character - it must not be present).

You can also freely combine both syntax types (both will use the same file) like

    ["B_Soldier_lite_F", "B_Soldier_F.sqf"],
    "B_Soldier_F"

which would make both `B_Soldier_lite_F` and `B_Soldier_F` use
`B_Soldier_F.sqf`.

Importing back into Arsenal
---------------------------

To load a previously set loadout back into the arsenal, you simply need to
reverse the `this` / `_this` replacement process, so that you're importing
(into Arsenal) code with 'this' instead of `_this`.

Additional notes (Advanced)
---------------------------

Note that Arsenal exports are essentially SQF scripts that modify the units
directly. You can therefore choose to re-use only some parts of the loadout
(ie. not applying face/voice) or add your own extra loadout-unrelated logic
that should be applied on every soldier matching given class.

You can also use this approach to define "hierarchical" loadouts by having
a more generic class (ie. `SoldierWB` or `CAManBase`) with changes you want
to apply always and more fine-grained details in per-endclass files.

Note though, that you would need to hand-edit the loadouts as all Arsenal
exports by default remove all previous gear.

Also note that no execution order of the files is guaranteed - if you specify
loadouts for both `CAManBase` and `B_Soldier_F`, either of them can be executed
first. Therefore - with this hierarchical approach - you need to be very
careful to **not** remove items in one file and add in another, you need to
"replace" loadout pieces within the same file, ie.

- `CAManBase`

  - remove any launcher, add AA launcher
  - remove pistol, remove pistol ammo, add race starter pistol + ammo

- `B_Soldier_F`

  - remove main weapon, remove its ammo, add new main weapon + ammo
  - remove all grenades, add 4 frag grenades
  - remove all smoke shells, add 2 white smoke shells

In other words, the changes must not conflict or affect each other and the
final result must always fit in the inventory.

You are not guaranteed which file runs first, but you are guaranteed,
by the Arma engine, that only one file will be running at a time.
