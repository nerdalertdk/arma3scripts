/*
	File: IAT_KeyDown.sqf
	Author: itsatrap
	Description:
		Blocks some view exploits and side chat voice.
	Parameter(s):
		NONE
	Install:
		Add #include "IAT_KeyDown.sqf" in init.sqf
*/

IAT_keyDown = compileFinal
"
	private[""_code"",""_handled""];
	_code = (_this select 1);
	_handled = false;

	switch (true) do 
	{
		case ( _code in actionKeys ""ForceCommandingMode"" );
		case ( _code in actionKeys ""TacticalView"" );
		case ( _code in actionKeys ""SelectGroupUnit0"" );
		case ( _code in actionKeys ""SelectGroupUnit1"" );
		case ( _code in actionKeys ""SelectGroupUnit2"" );
		case ( _code in actionKeys ""SelectGroupUnit3"" );
		case ( _code in actionKeys ""SelectGroupUnit4"" );
		case ( _code in actionKeys ""SelectGroupUnit5"" );
		case ( _code in actionKeys ""SelectGroupUnit6"" );
		case ( _code in actionKeys ""SelectGroupUnit7"" );
		case ( _code in actionKeys ""SelectGroupUnit8"" );
		case ( _code in actionKeys ""SelectGroupUnit9"" );
		case ( _code in actionKeys ""GroupPagePrev"" );
		case ( _code in actionKeys ""GroupPageNext"" );
		case ( _code in actionKeys ""SelectAll"" );
		case ( _code in actionKeys ""CommandingMenu0"" );
		case ( _code in actionKeys ""CommandingMenu1"" );
		case ( _code in actionKeys ""CommandingMenu2"" );
		case ( _code in actionKeys ""CommandingMenu3"" );
		case ( _code in actionKeys ""CommandingMenu4"" );
		case ( _code in actionKeys ""CommandingMenu5"" );
		case ( _code in actionKeys ""CommandingMenu6"" );
		case ( _code in actionKeys ""CommandingMenu7"" );
		case ( _code in actionKeys ""CommandingMenu8"" );
		case ( _code in actionKeys ""CommandingMenu9"" ): 
		{
			_handled = true;
		};
		case ( _code in actionKeys ""PushToTalkSide"" );
		case ( _code in actionKeys ""PushToTalkAll"" );
		case ( _code in actionKeys ""PushToTalkDirect"" );
		case ( _code in actionKeys ""VoiceOverNet"" );
		case ( _code in actionKeys ""PushToTalk"" ): 
		{
			if ( currentChannel in [0,1] ) then
			{
				  setCurrentChannel 5;
			};
		};
	};
	_handled;
";
// Only run on player PC
if (hasInterface) then
{
	private["_IAT_keyDownKeybaord","_IAT_keyDownMouse","_IAT_keyDownJoystick"];
	// Wait till IGUI is loaded
	waitUntil {!isNull findDisplay 46};
	_IAT_keyDownKeybaord	= (findDisplay 46) displayAddEventHandler ["KeyDown","_this call IAT_keyDown"];
	_IAT_keyDownMouse		= (findDisplay 46) displayAddEventHandler ["MouseButtonDown","_this call IAT_keyDown"];
	_IAT_keyDownJoystick	= (findDisplay 46) displayAddEventHandler ["JoystickButton","_this call IAT_keyDown"];
};
