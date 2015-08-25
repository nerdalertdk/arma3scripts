/*
	File: IAT_KeyDown.sqf
	Author: itsatrap
	Description:
		Blocks some view exploits and side chat voice.
	Parameter(s):
		NONE
	Install:
		Add #include IAT_KeyDown.sqf in init.sqf
*/

IAT_drawGroup = compileFinal
{"
	private[""_code"",""_handled""];
	_code = (_this select 1);
	_handled = false;

	switch (true) do 
	{
		// No script kiddies
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

		// No side-chat speak
		// 0 - Global, 1 - Side, 2 - Command, 3 - Group, 4 - Vehicle, 5 - Direct
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
"};
// Only run on player PC
if (hasInterface) then
{
	private["_display","_IAT_drawGroupKeybaord","_IAT_drawGroupMouse","_IAT_drawGroupJoystick"];
	// Wait till IGUI is loaded
	waitUntil {!isNull findDisplay 46};
	_display					= (findDisplay 46);
	_IAT_drawGroupKeybaord		= _display displayAddEventHandler ["KeyDown","{_this call IAT_drawGroup;}"];
	_IAT_drawGroupMouse		= _display displayAddEventHandler ["MouseButtonDown","{_this call IAT_drawGroup;}"];
	_IAT_drawGroupJoystick		= _display displayAddEventHandler ["JoystickButton","{_this call IAT_drawGroup;}"];
};