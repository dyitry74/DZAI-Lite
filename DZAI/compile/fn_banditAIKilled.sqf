/*
		fnc_banditAIKilled (DZAI Lite Version)
		
		Description: Updates active AI count upon unit death. Script is shared between AI spawned from static and dynamic triggers.
		
        Usage: [_unit,_weapongrade] spawn fnc_banditAIKilled;
		
		Last updated: 5:27 PM 6/25/2013
*/

private["_weapongrade","_victim","_killer","_trigger","_gradeChances","_unitGroup","_groupSize"];
_victim = _this select 0;
_killer = _this select 1;

//Remove temporary NVGs.
if ((_victim getVariable["removeNVG",0]) == 1) then {_victim removeWeapon "NVGoggles";}; //Remove temporary NVGs from AI.

//Set study_body variables.
_victim setVariable["bodyName","DZAI Unit",true];
_victim setVariable["deathType","bled",true];

//Update AI count
_unitGroup = (group _victim);
_groupSize = _unitGroup getVariable "groupSize";
_groupSize = _groupSize - 1;
DZAI_numAIUnits = DZAI_numAIUnits - 1;
_unitGroup setVariable ["groupSize",_groupSize];
if (DZAI_debugLevel > 1) then {diag_log format ["DZAI Extended Debug: Group %1 has group size: %2.",_unitGroup,_groupSize];};

if (!isPlayer _killer) exitWith {};

_unitGroup setBehaviour "COMBAT";

_trigger = _victim getVariable "trigger";

if (DZAI_findKiller) then {0 = [_victim,_killer,_unitGroup] spawn fnc_findKiller;};
