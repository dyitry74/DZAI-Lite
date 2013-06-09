/*
	fnc_unitInventory
	
	Description: Adds binoculars/NVGoggles to AI unit. If unit has weapongrade 2 or higher, assigns temporary unlootable NVGs if not previously given one and DZAI_tempNVGs is set to true.
	
	Usage: [_unit,_weapongrade] call fnc_unitInventory;
	
	Last updated: 6:11 PM 6/8/2013
*/
    private ["_unit","_weapongrade","_gadgetsArray"];
    _unit = _this select 0;
	_weapongrade = _this select 1;
	
	_gadgetsArray = [];
	if (_weapongrade < 2) then {
		_gadgetsArray = DZAI_gadgets0;
	} else {
		_gadgetsArray = DZAI_gadgets1;
	};

	private ["_chance","_gadget"];
	//diag_log format ["DEBUG :: Counted %1 tools in _gadgetsArray.",(count _gadgetsArray)];
	for "_i" from 0 to ((count _gadgetsArray) - 1) do {
		_chance = ((_gadgetsArray select _i) select 1);
		//diag_log format ["DEBUG :: %1 chance to add gadget.",_chance];
		if ((random 1) < _chance) then {
			_gadget = ((_gadgetsArray select _i) select 0);
			_unit addWeapon _gadget;
			//diag_log format ["DEBUG :: Added gadget %1 as loot to AI inventory.",_gadget];
		};
	};
	
	//If unit has weapongrade 2 or 3 and was not given NVGs, give the unit temporary NVGs which will be removed at death. Set DZAI_tempNVGs to true in variables config to enable temporary NVGs.
	if ((_weapongrade > 1) && !(_unit hasWeapon "NVGoggles") && (DZAI_tempNVGs)) then {
		_unit addWeapon "NVGoggles";
		_unit setVariable["removeNVG",1,false];
		if (DZAI_debugLevel > 1) then {diag_log "DZAI Extended Debug: Generated temporary NVGs for AI.";};
	};
	