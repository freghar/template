Logic and Trigger scripts
=========================

These are meant to be used from the Editor ONLY (!) and, being called from

- the 'On Activation' field of triggers
- the init line of logic entities

and are meant to utilize global variables to limit passed arguments.

They are also meant to run only on the server, preparing JIP logic as
(if) needed. This is because if each client executes the trigger / init line
independently, JIP-ed players would run it much later or repeatedly, potentially
having side effects if the trigger covers units which were not there on mission
start (ie. trigger to hide AI units could hide player units!) or if the code
is designed to run only once with a global effect.

Use remoteExec with the 'jip' argument if you need to execute code on clients.
Most commands however have 'Global' variants, which add their effect to the
JIP queue automatically, so you don't need to care.

Each function also **deletes the trigger/logic** after spawning or calling its
functionality, to reduce any mid-mission overhead as the trigger condition is
evaluated every 0.5secs, even when the trigger has already been activated.
This is automatically synced to newly JIP-ed clients, for which the trigger
won't run at all (because deleteVehicle is global).

Logic entities don't have the same disadvantage, but it's still one less unit
to sync on JIP, so it gets deleted as well.

These functions work best at mission start with trigger condition set to 'true'
(for trigger funcs) instead of 'this', to trigger immediately.

Logic vs Triggers
-----------------

When adding additional functions;

Use triggers if the performed code is not mission-start-sensitive (can happen
after mission starts) and if you can make use of multiple trigger properties
such as area shape/size, trigger rotation, position, text, etc.

Use logic entities if you need to perform a possibly unscheduled (blocking)
code before the mission starts (before briefing screen) or generally when the
code doesn't make use of trigger-like properties.
