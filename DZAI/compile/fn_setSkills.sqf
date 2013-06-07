
/*
	fnc_setSkills
	
	Description: Based on a given weapongrade value, assigns skill parameters to a given AI unit. Units with higher weapongrade values have higher skill parameters.
	
	Usage: [_unit,_weapongrade] call fnc_setSkills;
	
	Last updated: 6/2/2013
*/
private ["_unit", "_weapongrade"];
_unit = _this select 0;
_weapongrade = _this select 1;

switch (_weapongrade) do {
	case 0: {
		_unit setSkill ["aimingAccuracy",(0.10 + random 0.10)];
		_unit setSkill ["aimingShake",(0.15 + random 0.15)];
		_unit setSkill ["aimingSpeed",(0.40 + random 0.20)];
		_unit setSkill ["endurance",(0.50 + random 0.40)];
		_unit setSkill ["spotDistance",(0.20 + random 0.20)];
		_unit setSkill ["spotTime",(0.30 + random 0.20)];
		_unit setSkill ["courage",(0.50 + random 0.30)];
		_unit setSkill ["reloadSpeed",(0.60 + random 0.40)];
		_unit setSkill ["commanding",(0.40 + random 0.30)];
		_unit setSkill ["general",(0.40 + random 0.30)];
	};
	case 1: {
		_unit setSkill ["aimingAccuracy",(0.15 + random 0.15)];
		_unit setSkill ["aimingShake",(0.20 + random 0.15)];
		_unit setSkill ["aimingSpeed",(0.50 + random 0.20)];
		_unit setSkill ["endurance",(0.60 + random 0.40)];
		_unit setSkill ["spotDistance",(0.30 + random 0.20)];
		_unit setSkill ["spotTime",(0.40 + random 0.20)];
		_unit setSkill ["courage",(0.70 + random 0.30)];
		_unit setSkill ["reloadSpeed",(0.60 + random 0.40)];
		_unit setSkill ["commanding",(0.50 + random 0.30)];
		_unit setSkill ["general",(0.50 + random 0.30)];
	};
	case 2: {
		_unit setSkill ["aimingAccuracy",(0.15 + random 0.20)];
		_unit setSkill ["aimingShake",(0.25 + random 0.20)];
		_unit setSkill ["aimingSpeed",(0.60 + random 0.20)];
		_unit setSkill ["endurance",(0.70 + random 0.30)];
		_unit setSkill ["spotDistance",(0.50 + random 0.20)];
		_unit setSkill ["spotTime",(0.50 + random 0.20)];
		_unit setSkill ["courage",(0.80 + random 0.20)];
		_unit setSkill ["reloadSpeed",(0.70 + random 0.30)];
		_unit setSkill ["commanding",(0.60 + random 0.30)];
		_unit setSkill ["general",(0.60 + random 0.30)];
	};
	case 3: {
		_unit setSkill ["aimingAccuracy",(0.20 + random 0.25)];
		_unit setSkill ["aimingShake",(0.35 + random 0.25)];
		_unit setSkill ["aimingSpeed",(0.70 + random 0.20)];
		_unit setSkill ["endurance",(0.80 + random 0.20)];
		_unit setSkill ["spotDistance",(0.70 + random 0.20)];
		_unit setSkill ["spotTime",(0.60 + random 0.20)];
		_unit setSkill ["courage",(0.80 + random 0.20)];
		_unit setSkill ["reloadSpeed",(0.70 + random 0.30)];
		_unit setSkill ["commanding",(0.70 + random 0.30)];
		_unit setSkill ["general",(0.70 + random 0.30)];
	};
};
