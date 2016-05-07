Init Line functions
===================

These functions should be used on unit init lines (Editor) ONLY! They make use
of the 'this' global variable implicitly.

The idea behind this category is to provide an easy-to-use (copy-paste)
functionality to mission creators, without them having to care too much about
locality, respawn, JIP, synchronization, waiting/sleeping, etc.

These functions therefore **have to** account for:

- Init line behavior in Arma 3 being different to previous BI games, running
  for JIP players as well. This can result in nasty glitches if not taken care
  of explicitly. As a general recommendation:
  - At the mission start, ensure the logic is run only once (on the server).
  - Synchronize the result for JIP players in some way (not necessarily running
    the same logic/code).
- Other functions on the same init line, without race conditions.
- The mission creation not necessarily having deep scripting knowledge.

The main reason for this section, though, is the potential complexity arising
from MP-compatibility of the functions, making even seemingly simple logic
complex in a very specific way due to how unit init lines behave.

Taking care of this specific complexity in generic functions would just clutter
the code, hence this explicit category.

Mission Start-time Logic
------------------------

Some of these functions are designed to be used on Logic entities to alter
game environment at a mission start. This happens (preferably) in unscheduled
environment, eg. before the simulation starts.

Some good practices when making these functions:

- run only on server
- prefer `*Global` commands, so the effect is visible for JIP-ed clients
  - if unavailable, use `remoteExec` + add the action into JIP queue manually
- always delete the initialized unit and any helper units once the intended
  action has been performed (or script spawned)
  - this is to save simulation and network overhead

Some of these functions also utilize synchronized Trigger objects as a mission
creator friendly way of defining areas, shapes, positions, etc. In these cases,
the triggers are removed during the function logic (see removal mention above)
and are never run, so their condition is irrelevant.
