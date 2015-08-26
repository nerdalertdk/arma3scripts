/*
	File: IAT_KeyDown.sqf
	Author: Michael <https://github.com/nerdalertdk>
	Description:
		Blocks some view exploits and side chat voice.
		Optional: Use Ctrl/shift + Space to open/close doors if "IAT_openDoors.sqf" is installed
	Parameter(s):
		NONE
	Install:
		Add #include "IAT_KeyDown.sqf" in init.sqf
*/

// Only run on player PC
if (!hasInterface) exitWith{};

//IAT_keyDown = compileFinal

// 13302
IAT_keyDown = compile
"
	if !(alive player) exitWith {};
		
	private[""_key"",""_handled"",""_shift"",""_ctrl""];
	_key		= _this select 1;
	_shift	= _this select 2;
	_ctrl	= _this select 3;
	_handled	= false;

	if (!(isNil ""IAT_openDoor"") && {(_ctrl && _key == 57) || (_shift && _key == 57)}) then
	{
		systemChat ""door"";
		call IAT_openDoor;
		_handled = true;
	};
	
	switch (true) do 
	{
		case ( _key in actionKeys ""ForceCommandingMode"" );
		case ( _key in actionKeys ""TacticalView"" );
		case ( _key in actionKeys ""GroupPagePrev"" );
		case ( _key in actionKeys ""GroupPageNext"" );
		case ( _key in actionKeys ""SelectAll"" );
		case ( _key in actionKeys ""CommandingMenu0"" );
		case ( _key in actionKeys ""CommandingMenu1"" );
		case ( _key in actionKeys ""CommandingMenu2"" );
		case ( _key in actionKeys ""CommandingMenu3"" );
		case ( _key in actionKeys ""CommandingMenu4"" );
		case ( _key in actionKeys ""CommandingMenu5"" );
		case ( _key in actionKeys ""CommandingMenu6"" );
		case ( _key in actionKeys ""CommandingMenu7"" );
		case ( _key in actionKeys ""CommandingMenu8"" );
		case ( _key in actionKeys ""CommandingMenu9"" ): 
		{
			_handled = true;
		};
		case ( _key in actionKeys ""PushToTalkSide"" );
		case ( _key in actionKeys ""PushToTalkAll"" );
		case ( _key in actionKeys ""PushToTalkDirect"" );
		case ( _key in actionKeys ""VoiceOverNet"" );
		case ( _key in actionKeys ""PushToTalk"" ): 
		{
			if ( currentChannel in [0,1] ) then
			{
				  setCurrentChannel 5;
			};
		};
	};
	_handled;
";
waitUntil {!isNull findDisplay 46};
private["_IAT_keyDownKeybaord"];
_IAT_keyDownKeybaord	= (findDisplay 46) displayAddEventHandler ["KeyDown","_this call IAT_keyDown"];
