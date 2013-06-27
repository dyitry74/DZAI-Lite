/*
		fnc_banditAIKilled
		
		Description: Adds loot to AI corpse if killed by a player, reveals the killer to the victim's group.
		
        Usage:
		
		Last updated: 6:36 PM 6/26/2013
*/

private["_weapongrade","_victim","_killer","_removeNVG","_trigger","_gradeChances","_unitGroup"];
_victim = _this select 0;
_killer = _this select 1;

_removeNVG = _victim getVariable["removeNVG",0];
if (_removeNVG == 1) then {_victim removeWeapon "NVGoggles";}; //Remove temporary NVGs from AI.

//Set study_body variables.
_victim setVariable["bodyName","DZAI Unit",true];
_victim setVariable["deathType","bled",true];

if (!isPlayer _killer) exitWith {};

_unitGroup = group _victim;
_unitGroup setBehaviour "COMBAT"; 

if (DZAI_findKiller) then {0 = [_victim,_killer,_unitGroup] spawn fnc_findKiller;};
