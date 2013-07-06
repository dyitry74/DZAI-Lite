/*
	fnc_createUnit (DZAI Lite version)
	
	Description: Spawns an independent AI unit. Called internally by spawnBandits_random, respawnBandits_random, spawnBandits_bldgs, respawnBandits_bldgs, spawnBandits_markers, respawnBandits_markers.
	
	Usage: [_unitGroup,_spawnPos,_patrolDist,_trigger,_respawnLoc,_respawnType] call fnc_createUnit;
	
	_totalAI: Number of AI units to spawn for the given group.
	_unitGroup: Group to spawn AI unit. (Building-spawned AI: side 'resistance', Random/Marker-spawned AI: side 'east')
	_spawnPos: Position to create AI unit.
	_trigger: The trigger object responsible for spawning the AI unit.
	
	Last updated: 5:30 PM 7/6/2013
	
*/
private ["_totalAI","_spawnPos","_unitGroup","_trigger"];
if (!isServer) exitWith {};

_totalAI = _this select 0;
_unitGroup = _this select 1;
_spawnPos = _this select 2;
_trigger = _this select 3;

for "_i" from 1 to _totalAI do {
	private ["_type","_unit","_weapongrade"];
	_type = DZAI_BanditTypes call BIS_fnc_selectRandom;									// Select skin of AI unit
	_unit = _unitGroup createUnit [_type, _spawnPos, [], 0, "FORM"];					// Spawn the AI unit
	[_unit] joinSilent _unitGroup;														// Add AI unit to group

	_unit setVariable ["trigger",_trigger];												// Record the trigger from which the AI unit was spawned
	_unit addEventHandler ["Killed",{_this spawn fnc_updateDead;}];					// Remove corpse after specified time.

	if (DZAI_taserAI) then {
		_unit addEventHandler ["HandleDamage",{_this call fnc_damageAI;_this call DDOPP_taser_handleHit;}];
	} else {
		_unit addEventHandler ["HandleDamage",{_this call fnc_damageAI;}];};					// Handle incoming damage. Note: AI durability can be modified in dayz_ai_variables.sqf
	_unit addEventHandler ["Killed",{[_this,"banditKills"] call local_eventKill;_this call fnc_banditAIKilled;_this spawn fnc_spawn_deathFlies;(_this select 0) setDamage 1;}];
		
	_unit setVehicleInit "if (isServer) then {[this] spawn fnc_aiBrain;};";			// Background-running script that automatically reloads ammo when depleted, and sets hostility to nearby zombies
	_weapongrade = [DZAI_weaponGrades,DZAI_gradeChancesDyn] call fnc_selectRandomWeighted;
	[_unit, _weapongrade] call fnc_unitSelectWeapon;									// Add rifle
	0 = [_unit, _weapongrade] spawn fnc_unitInventory;									// Add backpack and chance of binoculars
	0 = [_unit, _weapongrade] spawn fnc_setSkills;										// Set AI skill

	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	_unit allowDammage true;
	if (DZAI_debugLevel > 1) then {diag_log format["DZAI Extended Debug: Spawned AI Type %1 with weapongrade %2 (fn_createUnit).",_type,_weapongrade];};
};

_unitGroup selectLeader ((units _unitGroup) select 0);
_unitGroup allowFleeing 0;
processInitCommands;
