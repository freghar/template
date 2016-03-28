/*
 * make '_this' unit sit down and remain seated as long as it considers
 * the situation safe (ie. no nearby enemy revealed, no bodies, etc.)
 *
 * note: doesn't work directly from a unit init line, probably due to
 *       races in unit initialization, use:
 *       0 = this spawn { sleep 5+random(10); _this call thisfunction; };
 */

_this setBehaviour "SAFE";
_this action ["SITDOWN", _this];
_this disableAI "ANIM";
_this spawn {
    waitUntil {behaviour _this != "SAFE"};
    _this enableAI "ANIM";
};
