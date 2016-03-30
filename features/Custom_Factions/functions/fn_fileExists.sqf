/* 
 * checks if file '_this' exists
 * taken from http://killzonekid.com/arma-scripting-tutorials-kk_fnc_fileexists/
 */

private ["_ctrl", "_fileExists"];
disableSerialization;
_ctrl = findDisplay 0 ctrlCreate ["RscHTML", -1];
_ctrl htmlLoad _this;
_fileExists = ctrlHTMLLoaded _ctrl;
ctrlDelete _ctrl;
_fileExists
