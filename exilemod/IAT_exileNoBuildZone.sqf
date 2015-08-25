/*
	File: IAT_exileNoBuildZone.sqf
	Author: itsatrap.dk
	Description:
		WIP do not use
	Parameter(s):
		NONE
	Install:
		Add #include IAT_exileNoBuildZone.sqf in init.sqf
*/
private["_buildingList"];
_buildingList = compileFinal str [
	"Land_Mil_ControlTower",
	"Land_SS_hangar",
	"Land_Mil_Barracks_i",
	"Land_A_GeneralStore_01",
];

/*

ExileClientIsInConstructionMode = true;

ExileClientConstructionModePhysx = true;
ExileClientConstructionResult = 2;

["ConstructionAbortedInformation", [ExileClientConstructionObjectDisplayName]] call BIS_fnc_showNotification;

*/


IAT_exileNoBuildZone = compileFinal
{"
	if(!ExileClientIsInConstructionMode) exitwith {};
	private[""_list"",""_isNear""];
	_list = (_this select 0);
	_isNear = {typeOf _x in _list} count (nearestObjects[player, _list, 100] > 0);
	
	if (ExileClientIsInConstructionMode && _isNear) then
	{
		ExileClientConstructionModePhysx = true;
		ExileClientConstructionResult = 2;
	};
"};

// Only run on player PC
if (hasInterface) then
{
	waitUntil {alive player};
	[_buildingList] call = IAT_exileNoBuildZone;
};
