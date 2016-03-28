/*
 * make '_unit' strictly obey waypoint/zeus commands for '_secs' seconds
 * - works only if the unit hasn't acquired a target yet
 */

params ["_unit", "_secs"];

_unit disableAI "AUTOCOMBAT";
_unit disableAI "AUTOTARGET";
_unit disableAI "TARGET";
_unit disableAI "COVER";
_unit disableAI "SUPPRESSION";
_unit disableAI "FSM";
_unit setBehaviour "AWARE";
_unit setUnitPos "UP";

if (_secs > 0) then {
    0 = [_unit, _secs] spawn {
        params ["_unit", "_secs"];
        sleep _secs;
        _unit enableAI "AUTOCOMBAT";
        _unit enableAI "AUTOTARGET";
        _unit enableAI "TARGET";
        _unit enableAI "COVER";
        _unit enableAI "SUPPRESSION";
        _unit enableAI "FSM";
  };
};
