#include "..\..\include\common.h"

/*
 * pause execution in a scheduled environment for '_secs' seconds specified,
 * return immediately in a non-scheduled environment
 */

params ["_secs"];

#ifdef DEBUG
hint format ["sleeping for %1 seconds", _secs];
#endif

sleep _secs;
