/*
 * call '_code', passing it '_arg'
 * (for use with remoteExec)
 */

params ["_code", "_arg"];
_arg call _code;
