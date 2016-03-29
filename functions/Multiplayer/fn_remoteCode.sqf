/*
 * remotely call '_code', passing it '_arg'
 * (simple wrapper around using A3MT_fnc_call with remoteExec)
 *
 * for simpler cases, prefer remoteExec / remoteExecCall directly:
 *     [{ hint _this; }, 123] remoteExec ["A3MT_fnc_call"];
 */

params ["_code", "_arg", "_targets", "_jip"];
[_code, _arg] remoteExec ["A3MT_fnc_call", _targets, _jip];

/*
 * client-only mods need to do something like
 *
 * private _pvar = format ["A3MT_remoteCode_%1", str clientOwner];
 * call compile format ["%1 = %2", _pvar, "_code"];
 * publicVariable _pvar;
 * _arg remoteExec [_pvar, _targets, _jip];
 *
 * because they cannot rely on another function (A3MT_fnc_call) being available
 * on all clients - this limitation however doesn't apply to us as we can
 * define mission-wide functions that all clients always have
 */
