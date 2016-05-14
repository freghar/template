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

/* if non-existing, add a respawn handler for any respawning units */
if (isNil "A3MT_initAndRespawn_inited") then {
    A3MT_initAndRespawn_inited = addMissionEventHandler ["EntityRespawned", {
        params ["_unit", "_corpse"];
        if (!local _unit) exitWith {};
        private _code = _unit getVariable ["A3MT_initAndRespawn_code", {}];
        _unit call _code;
    }];
};

/* equivalent to isServer */
if (!local _unit) exitWith {};

_unit setVariable ["A3MT_initAndRespawn_code", _code, true];

/* call NOW */
_unit call _code;
