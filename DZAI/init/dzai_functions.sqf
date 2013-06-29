/*
	DZAI Functions
	
	Last Updated: 11:30 AM 6/28/2013
*/

waituntil {!isnil "bis_fnc_init"};
diag_log "[DZAI] Compiling DZAI functions.";
// [] call BIS_fnc_help;
//Compile general functions.
BIS_fnc_selectRandom = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_selectRandom.sqf";	//Altered version
fnc_setSkills = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_setSkills.sqf";
fnc_spawn_deathFlies = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_spawn_deathFlies.sqf";
fnc_unitInventory = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_unitInventory.sqf";
fnc_unitSelectWeapon = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_unitSelectWeapon.sqf";
fnc_banditAIKilled = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_banditAIKilled.sqf";
fnc_selectRandomWeighted = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_selectRandomWeighted.sqf";
fnc_createUnit = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_createUnit.sqf";
fnc_damageAI = 					compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_damageHandlerAI.sqf";
fnc_initTrigger = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_initTrigger.sqf";
fnc_BIN_taskPatrol = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\BIN_taskPatrol.sqf";
if (DZAI_debugMarkers < 1) then {	fnc_aiBrain = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\aiBrain.sqf";} else {
	fnc_aiBrain = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\aiBrain_debug.sqf";};
fnc_updateDead = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_updateDead.sqf";
if (DZAI_findKiller) then {
fnc_findKiller = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_findKiller.sqf";};
fnc_seekPlayer =				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_seekPlayer.sqf";
fnc_spawnBandits_dynamic = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\spawn_functions\spawnBandits_dynamic.sqf";
fnc_despawnBandits_dynamic = 	compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\spawn_functions\despawnBandits_dynamic.sqf";
	
DZAI_createGroup = {
	private["_unitGroup"];
	if (({(side _x) == EAST} count allGroups) <= 140) then {
		_unitGroup = createGroup east;
	} else {
		_unitGroup = createGroup resistance;
		diag_log "DZAI Warning: East side has exceeded 140 groups. Using Resistance as AI side.";
	};
	_unitGroup
};
