/*
	File: IAT_openDoor.sqf
	Author: Michael <https://github.com/nerdalertdk>
	Description:
		Open or Close the door you are looking at.
	Parameter(s):
		NONE
	Install:
		DONT IS WIP, not tested
		Add #include "IAT_openDoor.sqf" in init.sqf
*/

// Only run on player PC
if (!hasInterface) exitWith{};

IAT_openDoor = compileFinal
"
	if !(alive player) exitWith {};
	private[""_position0"", ""_position1"", ""_intersections"", ""_count"", ""_house"", ""_door""];
	_position0		= positionCameraToWorld [0, 0, 0];
	_position1		= positionCameraToWorld [0, 0, 3];

	_intersections	= lineIntersectsWith [ATLToASL _position0, ATLToASL _position1, objNull, objNull, true];

	_count			= count _intersections;
	if (_count isEqualTo 0) exitWith {};

	_house			= _intersections select (_count - 1);
	if (typeOf _house isEqualTo """") exitWith {};

	_intersections	= [_house, ""GEOM""] intersect [_position0, _position1];

	_door			= _intersections select 0 select 0;
	if (isNil ""_door"") exitWith {};
	_door 			= format [""%1_rot"", _door];

	_doorPhase 		= _house animationPhase _door;
	_doorPhase 		= [1,0] select (_doorPhase < 1);
	_house animate [_door, _doorPhase];
";
// It's alive :D
//waitUntil {alive player};
//IAT_openDoorsActive = true;