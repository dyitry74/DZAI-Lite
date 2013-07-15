/*
	DZAI Functions
	
	Last Updated: 2:01 PM 7/14/2013
*/

waituntil {!isnil "bis_fnc_init"};
diag_log "[DZAI] Compiling DZAI functions.";
// [] call BIS_fnc_help;
//Compile general functions.
if (isNil "SHK_pos_getPos") then {call compile preprocessFile "\z\addons\dayz_server\DZAI\SHK_pos\shk_pos_init.sqf";};
BIS_fnc_selectRandom = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_selectRandom.sqf";	//Altered version
fnc_unitInventory = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_unitInventory.sqf";
fnc_unitSelectWeapon = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_unitSelectWeapon.sqf";
fnc_banditAIKilled = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_banditAIKilled.sqf";
fnc_selectRandomWeighted = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_selectRandomWeighted.sqf";
fnc_createGroup = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_createGroup.sqf";
fnc_damageAI = 					compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_damageHandlerAI.sqf";
fnc_initTrigger = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_initTrigger.sqf";
fnc_BIN_taskPatrol = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\BIN_taskPatrol.sqf";
if (DZAI_debugMarkers < 1) then {
	fnc_unit_resupply = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\unit_resupply.sqf";
} else {
	fnc_unit_resupply = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\unit_resupply_debug.sqf";
};
fnc_updateDead = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_updateDead.sqf";
if (DZAI_findKiller) then {
	fnc_findKiller = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_findKiller.sqf";};
fnc_seekPlayer =				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_seekPlayer.sqf";
fnc_randomizeTriggers = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_randomizeTriggers.sqf";
fnc_spawnBandits_dynamic = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\spawn_functions\spawnBandits_dynamic.sqf";
fnc_despawnBandits_dynamic = 	compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\spawn_functions\despawnBandits_dynamic.sqf";
//Helicopter patrol scripts
fnc_heliDespawn =				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\heli_despawn.sqf";
if (DZAI_debugMarkers < 1) then {
	fnc_heliResupply = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\heli_resupply.sqf";
} else {
	fnc_heliResupply =			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\heli_resupply_debug.sqf";
};
fnc_spawnHeliPatrol	=			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\spawn_heliPatrol.sqf";
	
//DZAI group side assignment function. Detects when East side has too many groups, then switches to Resistance side.
DZAI_getFreeSide = {
	private["_groupSide"];
	if (({(side _x) == east} count allGroups) <= 140) then {

		_groupSide = east;
	} else {
		_groupSide = resistance;
		//diag_log "DZAI Warning: East side has exceeded 140 groups. Using Resistance as AI side.";
	};

	//diag_log format ["Assigned side %1 to AI group",_groupSide];
	
	_groupSide
};

//Selects a random dynamic trigger to use as AI helicopter's next waypoint
DZAI_heliRandomPatrol = {
	private ["_unitGroup"];
	_unitGroup = _this select 0;

	[_unitGroup,0] setWPPos (DZAI_heliWaypoints call BIS_fnc_selectRandom); 
	_unitGroup setCurrentWaypoint [_unitGroup,0];
	true
};

//Sets skills for unit based on their weapongrade value.
DZAI_setSkills = {
	private["_unit","_weapongrade","_skillArray"];
	_unit = _this select 0;
	_weapongrade = _this select 1;

	switch (_weapongrade) do {
		case 0: {
			_skillArray = DZAI_skill0;
		};
		case 1: {
			_skillArray = DZAI_skill1;
		};
		case 2: {
			_skillArray = DZAI_skill2;
		};
		case 3: {
			_skillArray = DZAI_skill3;
		};
		case "helicrew": {
			_skillArray = DZAI_heliCrewSkills;
		};
	};
	{
		_unit setskill [_x select 0,((_x select 1) + random (_x select 2))];
	} foreach _skillArray;
};

//Spawns flies on AI corpse
DZAI_deathFlies = {
	private["_unit","_position"];
	_unit = _this select 0;
	_position = getPosATL _unit;
	_unit = [_position, 0.1, 1.5] call bis_fnc_flies;
	true
};

//Randomizes AI helicopter waypoint pool
DZAI_randomizeHeliWPs = {
	if (DZA_debugLevel > 0) then {diag_log "DZAI Debug: Generating waypoints for AI helicopter patrol.";};
	for "_i" from 0 to ((10 max DZAI_dynTriggersMax) - 1) do {
		private["_wp"];
		_wp = [(getMarkerPos DZAI_centerMarker),(300 + random(DZAI_centerSize)),random(360),false] call SHK_pos;
		DZAI_heliWaypoints set [_i,_wp];
		//diag_log format ["DEBUG :: Generated waypoint %1 of %2 for AI helicopter patrol at %3.",_i,(5 max DZAI_dynTriggersMax),_wp];
		sleep 0.05;
	};
	true
};

DZAI_getUptime = {
	private ["_iS","_oS","_oM","_oH","_oD"];

	_iS = time;
	
	_oS = floor (_iS % 60);
	_oM = floor ((_iS % 3600)/60);
	_oH = floor ((_iS % 86400)/3600);
	_oD = floor ((_iS % 2592000)/86400);
	
	[_oD,_oH,_oM,_oS]
};
