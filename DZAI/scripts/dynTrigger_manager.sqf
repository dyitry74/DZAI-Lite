/*
	DZAI Dynamic Trigger Manager
	
	Description: Periodically selects a random dynamic trigger. If it is inactive and not marked for despawn, a probability check determines whether or not to move the trigger to a randomized location.
	
	Last updated: 5:49 PM 6/11/2013
*/

diag_log "Starting DZAI Dynamic Trigger Manager in 60 seconds.";
sleep 60;

diag_log "Starting DZAI Dynamic Trigger Manager.";
while {true} do {
	private ["_trigger","_isCleaning"];
	if ((random 1) < DZAI_dynRandomizeRate) then {
		if (DZAI_debugLevel > 0) then {diag_log "DZAI Debug: Selecting a random dynamic trigger to randomize location. (dynTrigger_manager)";};
		_trigger = DZAI_dynTriggerArray call BIS_fnc_selectRandom;
		_isCleaning = _trigger getVariable ["isCleaning",false];
		if ((!triggerActivated _trigger) && (!_isCleaning)) then {
		private ["_newPos"];
			_newPos = [(getMarkerPos DZAI_centerMarker),random(DZAI_centerSize),random(360),false,[1,500]] call SHK_pos;
			_trigger setPos _newPos;
			if (DZAI_debugLevel > 0) then {diag_log format["DZAI Debug: A dynamic trigger has been relocated to %1. (dynTrigger_manager)",_newPos];};
			if (DZAI_debugMarkers > 0) then {
				private["_marker"];
				_marker = format["trigger_%1",_trigger];
				_marker setMarkerPos _newPos;
				_marker setMarkerColor "ColorYellow";			//Reset trigger indicator to Ready.
				_marker setMarkerAlpha 0.8;
			};
		};
	} else {
		if (DZAI_debugLevel > 0) then {diag_log "DZAI Debug: Probability check failed, selecting random dynamic trigger in next cycle. (dynTrigger_manager)";};
	 };
	sleep DZAI_dynManagerRate;
};
