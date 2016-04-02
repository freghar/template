/*
 * registers that classes in array '_classNames' will have custom gear defined
 * uses global var A3MT_custom_gear as array
 *
 * class names are case insensitive
 *
*/

if (isNil "A3MT_custom_gear") then {
    A3MT_custom_gear = [];
};

{
    A3MT_custom_gear pushBackUnique toLower(_x);
} forEach _this;