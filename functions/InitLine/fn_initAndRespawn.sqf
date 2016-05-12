/*
 * execute '_code' *NOW* (called from unit init line) and on respawn of the unit
 * - when executed "now" (for the first time), it runs only where it is local,
 *   to prevent multiple executions
 *
 * a simple wrapper for calling any code + adding the same code to respawn EH,
 * MP-compatible, IOW on any client, so the unit can freely change locality and
 * the '_code' will fire on respawn where the unit is local at the time
 *
 * example:
 *   { systemChat format ["inited %1", _this] } call A3MT_fnc_initAndRespawn;
 */

private _unit = this;
private _code = _this;

/* equivalent to isServer */
if (!local _unit) exitWith {};

/* Respawn EH doesn't have access to init line context */
_unit setVariable ["A3MT_initAndRespawn_code", _code, true];

/* call NOW */
_unit call _code;

/* adding Respawn EH works ONLY if the unit is local, otherwise addEventHandler
 * is ignored (so not only the EH doesn't fire on non-local, it doesn't even
 * register in the first place!)
 *
 * to get around that, we hook the Local EH for everyone and when the unit is
 * being received, we register the Respawn EH
 * - we don't need to un-register it on transfer away from us as the Respawn EH
 *   is automatically deleted when the unit becomes non-local
 */

[_unit, {
    /* ie. if JIPed and the unit was already deleted */
    if (isNull _this) exitWith {};

    /* if it's already local, register the Respawn EH directly */
    if (local _this) then {
        _this addEventHandler ["Respawn", {
            params ["_unit", "_corpse"];
            private _code = _unit getVariable ["A3MT_initAndRespawn_code", {}];
            _unit call _code;
        }];
    };

    /* in any case, prepare for it being moved to us at some point */
    _this addEventHandler ["Local", {
        params ["_unit", "_islocal"];
        if (!_islocal) exitWith {};  /* only for receiving end */

        _unit addEventHandler ["Respawn", {
            params ["_unit", "_corpse"];
            private _code = _unit getVariable ["A3MT_initAndRespawn_code", {}];
            _unit call _code;
        }];
    }];
}] remoteExec ["BIS_fnc_call", 0];

//}] remoteExec ["BIS_fnc_call", 0, _unit];
/* note: the remoteExec above leaves "zombies" (dead scripts that refer to
 * objNull units which have been deleted) in JIP queue - there's currently
 * no easy way to prevent that, but Arma 1.60 will be able to attach the
 * JIP queue member name to an object, removing the exec automatically if
 * the object becomes null */
