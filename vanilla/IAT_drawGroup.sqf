/*
	File: IAT_drawGroup.sqf
	Author: Michael <https://github.com/nerdalertdk>
	Description:
		Shows you group members on the map
	Parameter(s):
		NONE
	Install:
		Add #include "IAT_drawGroup.sqf" in init.sqf
		
*/

// Only run on player PC
if (!hasInterface) exitWith{};
IAT_drawGroup = compileFinal
"
	if(!visibleMap) exitwith {};
	private[""_map"",""_iconArray"",""_playerGrp"",""_groupMembers"",""_unit"",""_names"",""_icon"",""_color""];
	_map 		= _this select 0;
	_iconArray 	= [];
	_playerGrp 	= (group player);
	_groupMembers = (units _playerGrp);
	
	{
		_unit 	= _x;
		_names 	= """";
		if(groupId (group _unit) isEqualTo groupId _playerGrp && {alive _unit}) then
		{
			_icon = getText (configFile/""CfgVehicles""/typeOf (vehicle _unit)/""Icon"");
			_color = [[1, 1, 1, 0.7], [1, 0, 0, 0.7], [0, 1, 0, 0.7], [0, 0, 1, 0.7], [1, 1, 0, 0.7]] select ([""MAIN"", ""RED"", ""GREEN"", ""BLUE"", ""YELLOW""] find (if (_unit == player) then {0} else {assignedTeam _unit})) max 0;
			{
				if(count (crew vehicle _unit) isEqualTo 1) exitwith
				{
					_names = name _unit;
				};
				_names = _names +  format[""%1, "",name _unit];
			} foreach (crew vehicle _unit);

			if(isStreamFriendlyUIEnabled) then {_names = ""John Doe"";};

			_iconArray pushback
			[
				_icon,
				_color,
				visiblePosition (vehicle _unit),
				0.25/ctrlMapScale _map,
				0.25/ctrlMapScale _map,
				direction (vehicle _unit),
				_names,
				0,
				(0.3 / 10)
			];
		};
	} foreach _groupMembers;

	{_map drawIcon _x;} count _iconArray;
";
private["_IAT_drawGroup"];
waitUntil {alive player};
_IAT_drawGroup = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw","_this call IAT_drawGroup"];