/*
 * pause execution in a scheduled environment for '_secs' seconds specified,
 * return immediately in a non-scheduled environment
 */

params ["_secs"];

sleep _secs;
