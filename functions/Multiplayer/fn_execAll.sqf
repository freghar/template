/*
 * execute '_code' on the all machines (all clients and the server)
 *
 * '_code' may be of type CODE or ARRAY, if it is ARRAY, the first member
 * is an arbitrary arg to be passed to the second member, which is the CODE
 * (similarly to BIS_fnc_call)
 */

if (typeName _this == "ARRAY") then {
    _this remoteExec ["BIS_fnc_call", 0];
} else {
    _this remoteExec ["call", 0];
};
