/*
	spawnTriggers_random

	Usage: 
	Description: 
	
	Last updated: 4:08 PM 6/7/2013
*/
private ["_numTriggers","_equipType","_trigOnAct","_retryCount","_triggerRadius"];
if (!isServer) exitWith {};

_numTriggers = _this select 0;							//Number of triggers to create
_equipType = if ((count _this) > 1) then {_this select 1} else {1};

if (_numTriggers == 0) exitWith {};						// Exit script if there is nothing to spawn

_trigOnAct = format["[%1,%2,%3,thisTrigger,thisList,%4] call fnc_spawnBandits_random_NR",DZAI_dynAIMin,DZAI_dynAIAdd,300,_equipType];

if (DZAI_debugLevel > 0) then {diag_log format["DZAI Debug: Spawning %1 dynamic trigger spawns in 60 seconds (spawnTriggers_random).",_numTriggers];};

sleep 60;

_retryCount = 0;
_triggerRadius = 600;

for "_i" from 1 to _numTriggers do {
	private ["_trigger","_trigPos","_nearbyPlayer"];
	_nearbyPlayer = false;
	_trigPos = [(getMarkerPos DZAI_centerMarker),random(DZAI_centerSize),random(360),false,[1,500]] call SHK_pos;
	_nearbyPlayer = ({isPlayer _x} count (_trigPos nearEntities [["AllVehicles","CAManBase"],_triggerRadius]) > 0);
	if (!_nearbyPlayer) then {
		_trigger = createTrigger ["EmptyDetector",_trigPos];
		_trigger setTriggerArea [_triggerRadius, _triggerRadius, 0, false];
		_trigger setTriggerActivation ["ANY", "PRESENT", true];
		_trigger setTriggerTimeout [5, 7, 10, true];
		_trigger setTriggerStatements ["{isPlayer _x} count thisList > 0;",_trigOnAct, "[thisTrigger] spawn fnc_despawnBandits_NR;"];
		if (DZAI_debugMarkers == 1) then {													//Adjust to debugLevel > 1
			private ["_markername","_marker"];
			_markername = format["trigger_%1",_trigger];
			_marker = createMarker[_markername,_trigPos];
			_marker setMarkerShape "ELLIPSE";
			_marker setMarkerType "Flag";
			_marker setMarkerBrush "SOLID";
			_marker setMarkerSize [_triggerRadius, _triggerRadius];
			_marker setMarkerColor "ColorYellow";
		};
		if (DZAI_debugLevel > 0) then {diag_log format["DZAI Debug: Dynamic trigger %1 of %2 spawned at %3 (spawnTriggers_random). Next trigger spawning in %4 seconds.",_i,_numTriggers,_trigPos,DZAI_dynSpawnDelay];};
		DZAI_curDynTrigs = DZAI_curDynTrigs + 1;
	} else {
		_retryCount = _retryCount + 1;
		diag_log format ["DEBUG :: A player is within activation distance of dynamic trigger. Retry Count: %1",_retryCount];
	};
	sleep DZAI_dynSpawnDelay;
};

if (_retryCount > 0) then {
	diag_log format ["DEBUG :: Retrying %1 dynamic trigger spawns.",_retryCount];
	[_retryCount,DZAI_dynEquipType] execVM '\z\addons\dayz_server\DZAI\scripts\spawnTriggers_random.sqf';
};
