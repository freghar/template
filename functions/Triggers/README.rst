Trigger scripts
===============

These are meant to be used from the Editor ONLY (!) and, being called from the
'On Activation' field, are meant to utilize global trigger variables to limit
passed arguments.

They are also meant to run only on the server, preparing JIP logic as
(if) needed. This is because if each client executed the trigger independently,
JIP-ed players would run it much later, potentially having side effects if the
trigger covers units which were not there on mission start (ie. trigger to hide
AI units could hide player units!).

It is therefore VERY important to ensure that the code runs only once and only
on the server. Use remoteExec with the 'jip' argument if you need to execute
code on clients. Most commands however have 'Global' variants, which add their
effect to the JIP queue automatically, so you don't need to care.

Each function also DELETES the trigger after it finishes with its logic. This
is to save performance as the trigger condition is evaluated every 0.5secs,
even when the trigger has already been activated. This is automatically synced
to newly JIP-ed clients, for which the trigger won't run at all.

These functions work best at mission start with condition set to 'true',
instead of 'this', to trigger immediately. Their effects mid-mission are not
guaranteed to work well.
