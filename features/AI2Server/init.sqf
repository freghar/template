/*
 * move Curator-spawned units under the rule of __SERVER__, disassociate
 * them from the original client to save bandwidth and make AI computations
 * on the server
 *
 * the ~30 secs delay is to allow the unit(s) to properly initialize on
 * the client (ie. various other EHs firing, WP creation, etc.) before being
 * transferred via setGroupOwner
 *
 * note that ie. Curator "Remote Control" transfers the group back to the
 * controlling client and this logic does not re-transfer it to server
 */

private _toserver = {
    params ["_curator", "_unit"];
    /* exclude Logic, Sound, etc. */
    if (!(_unit isKindOf "AllVehicles")) exitWith {};
    0 = _unit spawn {
        sleep (28+random 4);
        if (isNull _this) exitWith{};  /* got deleted ? */
        [(group _this), {
            if (groupOwner _this != 2) then {
                _this setGroupOwner 2;
            };
        }] call A3MT_fnc_execServer;
    };
};

/* add everywhere
 * - the EH seems fire on a client only when previously added on the client,
 *   even in cases when the Curator object is only server-side (mod-created)
 *   prior to assignCurator */
{
    _x addEventHandler ["CuratorObjectPlaced", _toserver];
} forEach allCurators;
