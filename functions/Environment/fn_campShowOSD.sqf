/*
 * client side function that displays message of current location with time and
 * possibly some other related info.
 *
 * Parameter(s):
 * _this select 0: array (optional)    - position (default: player's position)
 * _this select 1: array (optional)    - date in format [_year,_month,_day,_hour,_min] (default: current date)
 * _this select 2: string (optional)   - optional message
 *
 * A3 fonts used:
 *
 * PuristaLight
 * PuristaMedium
 * PuristaSemiBold
 * PuristaBold
 *
 * Following example displays current player position and time:
 *
 * [] call A3MT_fnc_campShowOSD;
 *
 * Note that function requires to be run in scheduled environment with call,
 * or use spawn in unscheduled.
 *
*/

//get current location text
private _get_location = {
    params ["_position"];
    private["_locations","_loc","_nearest_location"];

    _locations = nearestLocations [_position, ["NameCity", "NameCityCapital", "NameLocal", "NameMarine", "NameVillage"], 500];

    // filter-out locations without names
    {
        if (text _x == "") then
        {
            _locations set [_forEachIndex, objNull];
        };
    } forEach _locations;

    _locations = _locations - [objNull];

    if (count _locations > 0) then
    {
        _loc = _locations select 0;

        if (_position in _loc) then
        {
            _nearest_location  = text _loc;
        }
        else
        {
            _nearest_location = format[localize "STR_A3_NearLocation", text _loc];
        };
    }
    else
    {
        _nearest_location = "";
    };

    _nearest_location
};

// returns current mission date and time
private _get_daytime_data = {
    params ["_date"];
    private ["_year", "_month", "_day"];

    _year  = _date select 0;
    _month = _date select 1;
    _day   = _date select 2;

    if (_month < 10) then { _month = format["0%1", _month]; };
    if (_day < 10) then { _day = format["0%1", _day]; };

    //get date text
    private _text_date = format["%1-%2-%3 ", _year, _month, _day];

    //get time text
    private _time_hours = _date select 3;
    private _time_minutes = _date select 4;

    if (_time_hours < 10) then { _time_hours = format["0%1", _time_hours]; };
    if (_time_minutes < 10) then { _time_minutes = format["0%1", _time_minutes]; };

    private _text_time = format["%1:%2", _time_hours, _time_minutes];

    [_text_date, _text_time]
};

// don't display the message if it's already on screen
if (missionNamespace getVariable ["A3MT_fnc_camp_show__OSD_running", false]) exitWith {};

// set temporary global variable to true indicating function is running
A3MT_fnc_camp_show__OSD_running = true;

params [["_position", getPos player], ["_date", date], ["_custom_message", ""]];

// sum the output params & print it
private _text_date = ([_date] call _get_daytime_data) select 0;
private _text_time = ([_date] call _get_daytime_data) select 1;

private _output =
[
    [_text_date, "font='PuristaMedium'"],
    [_text_time, "font='PuristaMedium'"],
    ["", "<br/>"]
];

private _text_location=[_position] call _get_location;

if (_text_location!="") then {
    _output = _output + [[toUpper(_text_location), ""], ["", "<br/>"]];
};

private _map = toUpper(getText(configFile >> "CfgWorlds" >> worldName >> "description"));
_output = _output + [[_map, ""], ["", "<br/>"]];

if (_custom_message!="") then {
    _output = _output + [[toUpper(_custom_message), ""]];
};

private["_handle"];

//vertically align to cinematic border
_handle = [_output, safezoneX - 0.01, safeZoneY + (1 - 0.125) * safeZoneH, true, "<t align='right' size='1.0' font='PuristaLight'>%1</t>"] spawn BIS_fnc_typeText2;

waitUntil { scriptDone _handle };

// mark function ended
A3MT_fnc_camp_show__OSD_running = false;
