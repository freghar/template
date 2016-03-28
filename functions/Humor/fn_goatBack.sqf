/*
 * spawn a goat on the back of '_this' soldier
 */

private ["_group", "_animal"];
_group = createGroup Civilian;
_animal = _group createUnit ["Goat_random_F", position _this, [], 0, "NONE"];
_animal attachTo [_this, [0,0.4,1]];
[_animal, 85, 0] call bis_fnc_setpitchbank;
