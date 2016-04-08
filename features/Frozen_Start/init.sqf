/*
 * "freeze" the player on mission start / join, to prevent accidental firing
 * from a weapon and allow postInit scripts smooth execution
 *
 * note that the simulation is disabled only locally, other clients will see
 * the unit with enabled simulation - this is intentional, to lessen the
 * negative performance effect of 'enableSimulation true' for potentially
 * many units at once
 * also, as the goal is to prevent the player from moving the unit, enabled
 * simulation elsewhere doesn't matter much
 */

if (!hasInterface) exitWith {};

0 = [] spawn {
    /* JIP has null player */
    waitUntil { !isNull player };

    player enableSimulation false;

    /* left mouse button / fire is not disabled,
     * this neat hack is originally from KK */
    private _act = player addAction ["", {}, nil, -1,
                                     false, true, "DefaultAction"];

    waitUntil { time > 0 };
    sleep 30;

    player removeAction _act;
    player enableSimulation true;
};
