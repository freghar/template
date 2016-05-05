Custom Factions
===============

Description
-----------

This feature enables mission makers to create their own factions using Arsenal
exports. Exported loadouts will be applied to units based on their class name.
For example, if a mission maker places a blufor rifleman with class name of
`B_soldier_F`, a file `B_soldier_F.sqf` will be used to apply the correct gear.

This feature should work with any spawning mechanism - Zeus, Editor, various
unit-spawning mods, etc. Also works for JIP and activates on respawn.

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
6. add the class name to `classes.txt` inside the "loadouts" subfolder
7. all done! .. remember to post-process (`this` to `_this`) any newly inserted
   loadouts or loadout updates

Example classes.txt
-------------------

Specify a comma-separated list of strings as classes, do NOT put comma (,)
after the last string, ie.

    "B_Soldier_F", "B_Soldier_A_F"

or separated with new lines, ie.

    "B_Soldier_F",
    "B_Soldier_A_F"

You can put comments (anything starting with `//` will be ignored by the game)
on empty lines to describe the loadout for humans reading this file after you,
ie.

    // NATO Rifleman
    "B_Soldier_F",

    // NATO Ammo Bearer
    "B_Soldier_A_F"

All of the examples above use the class names for file names (inside "loadouts")
as well, ie. `B_Soldier_F` is taken as `B_Soldier_F.sqf`. You can override it
by specifying an array, denoted with square brackets, instead of just string,

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

Additionally, you can use code blocks directly instead of file names:

    // remove helmet from NATO Rifleman
    ["B_Soldier_F", { removeHeadgear _this } ]

Execution order
---------------

You are guaranteed that the classes and files specified in `classes.txt` will
always run sequentially, from top to bottom. This means you can have multiple
files per one class in a race-free way:

    // remove all gear
    ["B_Soldier_F", "util\clear_soldier.sqf"],

    // add basic NATO gear skeleton
    ["B_Soldier_F", "NATO\basic_loadout.sqf"],

    // add NVGs (dynamic sqf, adds different for each side)
    ["B_Soldier_F", "util\add_nvgs.sqf"]

This assumes hand-edited loadouts as pure Arsenal exports remove everything
the soldier previously had as their first action (look and you'll see).

As an alternative, instead of specifying a class name on multiple lines,
you can give more than one file per line (in any combination):

    // remove all and add basic NATO gear skeleton
    ["B_Soldier_F", "util\clear_soldier.sqf", "NATO\basic_loadout.sqf"],

    // add NVGs (dynamic sqf, adds different for each side)
    ["B_Soldier_F", "util\add_nvgs.sqf"]

In this case, the execution order is the same - files on one line execute
from left to right in addition to lines in the file executing from top to
bottom.

Inheritance
-----------

It is also possible to specify loadout for a parent class, in which case
all child classes will execute the code. This is denoted by the `+` sign
in class name:

    // remove all weapons and mags from all soldiers
    ["CAManBase+", "util\remove_arms.sqf"],

    // add basic NATO gear to Blufor/NATO units
    ["B_Soldier_base_F+", "NATO\basic_loadout.sqf"],

    // add a pistol to CSAT Riflemen only
    ["O_Soldier_F", "CSAT\give_pistol.sqf"]

As mentioned before, top-down and left-right execution logic is guaranteed,
therefore the removal **always** happens before the addition in this example.

The inheritance has to be explicitly requested via `+` because some existing
soldiers might be inherited by others, ie. A3 `b_survivor_f` is inherited from
`B_Soldier_F` and implicit inheritance would make both have the same loadout
whereas explicit one leaves `b_survivor_f` unaffected by default.

Manual gear load
----------------

The `A3MT_fnc_factionsExec` function can be provided in unit init field to
be executed specifically on that unit at a mission start. This can be useful
to ie. use a specific loadout for a given soldier. The function takes variable
number of files, just like a single line of `classes.txt`:

    [this, "B_Soldier_F.sqf", "util\no_nvgs.sqf"] call A3MT_fnc_factionsExec;

The execution order is, again, guaranteed to be from left to right.

It is **NOT** however guaranteed that this function executes after class-based
loadout definitions - it may execute after it, before it or even **interleave**
with it! **DO NOT** run code that conflicts with class-based loadouts via this
function.

For example - if you remove all + add basic gear via class-based loadouts and
(at the same time) add additional medic supplies via this function, the medic
supplies may be added before the 'remove all' commands and may get removed
as a result!

Only if you perform race-free atomic operations on the unit (actions that
can potentially run in parallel or interleave) should you use both class-based
execution and this manual function call at the same time.

Per-unit loadout additions
--------------------------

As `A3MT_fnc_factionsExec` ignores any existing class-based loadouts, to add
per-unit customizations that are guaranteed to run **after** the class-based
CODEs (on each unit initialization and respawn), use `A3MT_fnc_factionsAppend`.

This is useful if you want to have more "roles" than available classes and
don't want to result to using init lines for everybody.

One example being specialized teams of gunners + ammo bearers, you could have
20 such pairs, each using a different weapon + bag of ammo for it, with just
2 classes used.
Another example could be removing all default gear from all vehicles and adding
custom one to specific editor-placed vehicles (something not possible via
`A3MT_fnc_factionsExec` as there would be a removal vs addition race).

Importing back into Arsenal
---------------------------

To load a previously set loadout back into the arsenal, you simply need to
reverse the `this` / `_this` replacement process, so that you're importing
(into Arsenal) code with `this` instead of `_this`.

Additional notes (Advanced)
---------------------------

Note that Arsenal exports are essentially SQF scripts that modify the units
directly. You can therefore choose to re-use only some parts of the loadout
(ie. not applying face/voice) or add your own extra loadout-unrelated logic
that should be applied on every unit matching given class.

It is therefore possible to use this logic to
- specify vehicle (land/air/sea) cargo
- specify ammobox cargo
- modify behavior of animals (or remove them upon initialization)
- anything you can think of
