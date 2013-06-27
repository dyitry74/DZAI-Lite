/*
	fn_createGroups
	
	Description: Creates a non-respawning AI group of specified size. Used for spawning AI from dynamic triggers.
	
	Last updated: 12:12 PM 6/26/2013
*/
private ["_grpArray","_unitGroup","_totalAI","_patrolDist","_spawnPos","_pos","_trigger","_findPlayer","_startTime"];

_totalAI = _this select 0;
_patrolDist = _this select 1;
_spawnPos = _this select 2;
_pos = _this select 3;
_trigger = _this select 4;
_findPlayer = _this select 5;

_startTime = diag_tickTime;

_grpArray = [];

_unitGroup = grpNull;
if ((random 1) < 0.5) then {				//50% chance to choose East or Resistance as AI side to avoid reaching 140 group/side limit.
	_unitGroup = createGroup east;
} else {
	_unitGroup = createGroup resistance;
};
for "_i" from 1 to _totalAI do {
	[_unitGroup,_pos,_trigger] call fnc_createUnit;
	if (DZAI_debugLevel > 1) then {diag_log format["DZAI Extended Debug: AI %1 of %2 spawned (spawnBandits_dynamic).",_i,_totalAI];};
};

_unitGroup selectLeader ((units _unitGroup) select 0);
_unitGroup allowFleeing 0;

//Update AI count
_unitGroup setVariable ["groupSize",_totalAI];
DZAI_numAIUnits = DZAI_numAIUnits + _totalAI;
if (DZAI_debugLevel > 1) then {diag_log format ["DZAI Extended Debug: Group %1 has group size %2.",_unitGroup,_totalAI];};

if (_findPlayer) then {
	//Travel to player's position, then begin patrol.
	0 = [_unitGroup,_spawnPos,_patrolDist,(_this select 6)] spawn fnc_seekPlayer;	//_this select 6 >> _targetPlayer
	//diag_log "DEBUG :: Seeking target player.";
} else {
	//Begin patrol immediately.
	0 = [_unitGroup,_spawnPos,_patrolDist,DZAI_debugMarkers] spawn fnc_BIN_taskPatrol;
	//diag_log "DEBUG :: Beginning patrol.";
};

//_grpArray set [count _grpArray,_unitGroup];
_grpArray = [_unitGroup];

if (DZAI_debugLevel > 0) then {diag_log format["DZAI Debug: Spawned 1 new AI groups of %1 units each in %2 seconds (fn_createGroups_dyn).",_totalAI,(diag_tickTime - _startTime)];};

_grpArray