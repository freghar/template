/*
 * force client's UI to use one specific '_this' channel number by checking
 * the current channel on every frame (cost: 0.003ms) and re-setting it to
 * the specified one if it changes
 *
 * note: since vanilla uses the current channel for map marker placement, this
 *       also prevents players from using any other channel, HOWEVER mods like
 *       swt_markers or ACE use custom UI elements, which ignore this
 */

0 = [] spawn {
    while {true} do {
        waitUntil { currentChannel != _this };
        setCurrentChannel _this;
    };
};
