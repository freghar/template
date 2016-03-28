/*
 * turn street (and other) lights on (true) or off (false) as '_state'
 * in a given '_radius' around a source '_src' object
 */

params ["_state", "_src", "_radius"];

private "_damage";
if (_state) then { _damage = 0; } else { _damage = 0.97; };
/* TODO: use more specific (more decimal numbers) damage value to "store" info
 *       about which lights we disabled compared to what players destroyed
 *       (as destroyed lights won't have exactly the same damage value)
 *       and restore (on _state == true) only the ones we turned off */

{
    _x setHit ["light_1_hitpoint", _damage];
    _x setHit ["light_2_hitpoint", _damage];
    _x setHit ["light_3_hitpoint", _damage];
    _x setHit ["light_4_hitpoint", _damage];
} forEach nearestObjects [_src, [
    "Lamps_base_F",
    "PowerLines_base_F",
    "PowerLines_Small_base_F"
], _radius];
