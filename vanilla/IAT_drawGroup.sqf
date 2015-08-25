/*
	File: IAT_drawGroup.sqf
	Author: itsatrap
	Description:
		Shows you group members on the map
	Parameter(s):
		NONE
	Install:
		Add #include "IAT_drawGroup.sqf" in init.sqf
*/

IAT_drawGroup = compileFinal
"
	private[""_map"",""_iconArray"",""_playerGrp"",""_groupMembers"",""_unit"",""_names"",""_icon""];
	if(!visibleMap) exitwith {};
	_map 			= (_this select 0);
	_iconArray 		= [];
	_playerGrp 		= (group player);
	_groupMembers 	= (units _playerGrp);
	
	{
		_unit 	= _x;
		_names 	= """";
		if(groupId (group _unit) isEqualTo groupId _playerGrp) then
		{
			_icon = getText (configFile/""CfgVehicles""/typeOf (vehicle _unit)/""Icon"");
			{
				if(count (crew vehicle _unit) isEqualTo 1) exitwith
				{
					_names = name _unit;
				};

				if(alive _unit) then
				{
				  _names = _names +  format[""%1, "",name _unit];
				};
			} foreach (crew vehicle _unit);

			_iconArray pushback [
				_icon,
				[1,1,1,0.7],
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

	{_map drawIcon _x;} foreach _iconArray;
";

// Only run on player PC
if (hasInterface) then
{
	private["_IAT_drawGroup"];
	waitUntil {alive player};
	_IAT_drawGroup = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw","_this call IAT_drawGroup"];
};
