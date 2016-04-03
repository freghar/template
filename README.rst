Generic Arma 3 Mission Template
===============================

This template should serve as a base for creating missions, supporting
the mission creators with anything from small utility functions to larger
blocks of complex functionality, all in a (hopefully) modular fashion.

Key points
----------

- primary goal - provide SQF utility functions, be the toolbox for mission
  creators

  - functions for making AI sit down, street light control, terrain adjustment,
    safe unit teleport and many more

- secondary goal - provide ready-made features that can be simply enabled and
  used

  - respawn with Eden Arsenal-specified loadouts, extended Ares functionality,
    etc.

- have 0 runtime cost by default

  - have all core logic in preprocessor, meaning it runs when you enter mission
    lobby
  - unless features are enabled explicitly or functions called directly, it has
    no runtime logic and therefore no CPU overhead upon entering a mission

- be generic

  - do as much things vanilla-style as possible
  - don't go the "interoperability" route, adding workarounds for specific mods,
    prevent conflicts using generic means

- be minimalistic - big features belong to mods

Utility functions
-----------------

See the functions directory and further subdirectories, each function should
have a descriptive header, specifying its API as well as functionality.

The idea is to call these either from unit init lines in the mission editor,
runtime using an addon that allows arbitrary script code execution or from
init.sqf (or any other file) directly, depending on your needs.

Feel free to add your own functions (presumably with your own TAG / prefix)
into the structure, also feel free to modify init.sqf, description.ext and
other files as you see fit. These were designed to be mission creator friendly,
meaning the vast majority of template development happens outside these, so
you should have easy time keeping your local changes up with new template
releases.

Template "features"
-------------------

These are simple on/off switches that enable more complex functionality,
pre-packaged for mission creators to "just use", without having to do any
extra editor work.

To enable a function, simply uncomment it (remove the //) in userconfig.h.
Don't forget to check out its README (if it has one) inside a
features/Feature_Name/ directory.

Trimming down size
------------------

A template like this is obviously going to have more functionality than you
need. If you want the extra space back, feel free to remove functions or
features.

- to remove a function

  - remove its file in functions/Category/
  - remove its name from functions/functions.h

- to remove a feature

  - make sure it's not enabled in userconfig.h
  - remove its directory from features/

Other / Development / Contributing
----------------------------------

For further details, see the 'doc' directory.
