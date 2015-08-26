/*
	File: IAT_exileNoBuildZone.sqf
	Author: Michael (arma.itsatrap.dk)
	Description:
		WIP do not use
	Parameter(s):
		NONE
	Install:
		Add #include IAT_exileNoBuildZone.sqf in init.sqf
*/


/*

ExileClientIsInConstructionMode = true;

ExileClientConstructionModePhysx = true;
ExileClientConstructionResult = 2;

["ConstructionAbortedInformation", [ExileClientConstructionObjectDisplayName]] call BIS_fnc_showNotification;


// 500m near safezones ***************************
	{
		private ["_pos", "_radius", "_name","_distanceToSafezone","_moveAway","_minDistanceToSafezone"];
		_pos = _x select 0;
		_radius = _x select 1;
		_name = _x select 2;
		_distanceToSafezone = (player distance _pos);
		if(worldName == "namalsk") then {
			_minDistanceToSafezone = 300;
		} else {
			_minDistanceToSafezone = 500;
		};
		
		if (_distanceToSafezone < _minDistanceToSafezone) then {
			_cancel = true;
			_moveAway = (500 - _distanceToSafezone);
			_reason = format["\nYou are building too close to a safe zone %2.\nYou need to move %1m away to build.", round(_moveAway),_name];
		};
	true
	} count Safezones;

*/

private["_IAT_buildingList"];
_IAT_buildingList = compileFinal str [
	"Land_Mil_ControlTower",
	"Land_SS_hangar",
	"Land_Mil_Barracks_i",
	"Land_A_GeneralStore_01"
];

IAT_exileNoBuildZone = compileFinal format
["
	if(!ExileClientIsInConstructionMode) exitwith {};
	private[""_isNear""];
	_isNear = {typeOf _x in %1} count (nearestObjects[player, %1, 100] > 0);
	
	if (ExileClientIsInConstructionMode && _isNear) then
	{
		ExileClientConstructionResult = 2;
	};
",call _IAT_buildingList];

// Only run on player PC
if (hasInterface) then
{
	waitUntil {alive player};
	call IAT_exileNoBuildZone;
};
