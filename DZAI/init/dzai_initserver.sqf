/*
	DZAI Lite Server Initialization File
	
	Description: Handles startup process for DZAI Lite. Does not contain any values intended for modification.
	
	Last updated: 8:24 PM 6/9/2013
*/

diag_log "[DZAI] Initializing DZAI Lite addon. Reading dzai_variables.sqf.";

//Load DZAI variables
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\init\dzai_variables.sqf";
call compile preprocessFile "\z\addons\dayz_server\DZAI\SHK_pos\shk_pos_init.sqf";

createcenter east;											//Create centers for all sides
createcenter west;
createcenter resistance;
resistance setFriend [east, 1];								//Resistance (AI) is hostile to West (Player), but friendly to East (AI).
resistance setFriend [west, 0];	
EAST setFriend [WEST, 0];									//East (AI) is hostile to West (Player), but friendly to Resistance (AI).
EAST setFriend [resistance, 1];	
WEST setFriend [EAST, 0];									//West (Player side) is hostile to all.
WEST setFriend [resistance, 0];

	//waituntil {!isnil "bis_fnc_init"};
	//waituntil {!isnil "BIS_fnc_selectRandom"};
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
	fnc_createAI_NR = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_createAI_NR.sqf";
	fnc_damageAI = 					compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_damageHandlerAI.sqf";
	//fnc_getGradeChances =			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_getGradeChances.sqf";
	fnc_initTrigger = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_initTrigger.sqf";
	fnc_BIN_taskPatrol = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\BIN_taskPatrol.sqf";
	if (DZAI_debugMarkers < 1) then {	fnc_aiBrain = compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\aiBrain.sqf";} else {
		fnc_aiBrain = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\aiBrain_debug.sqf";};
	fnc_deleteVictim = 				compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\compile\fn_deleteVictim.sqf";
	
	fnc_spawnBandits_random_NR = 	compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\spawn_functions\spawnBandits_random_NR.sqf";
	fnc_despawnBandits_NR = 		compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\spawn_functions\despawnBandits_NR.sqf";
	
	
//Load default DZAI loot tables. These tables include weapons and other items that can be added to an AI unit's inventory.
//Do not delete this file, as it is required for DZAI to work.
#include "base_classname_configs\base_classnames.sqf"

private["_worldname"];
_worldname=toLower format ["%1",worldName];

_this = createMarker ["DZAI_centerMarker", (getMarkerPos 'center')];
_this setMarkerType "Empty";
_this setMarkerBrush "Solid";
DZAI_centerMarker = _this;
DZAI_centerSize = 4500;
DZAI_dynTriggersMax = 15;
		
switch (_worldname) do {
	case "chernarus":
	{
		DZAI_centerMarker setMarkerPos [7197.9736, 8631.29];
		DZAI_centerSize = 5250;
		DZAI_dynTriggersMax = 17;
	};
	case "utes":
	{
		DZAI_centerMarker setMarkerPos [3638.7322, 3728.3191];
		DZAI_centerSize = 900;
		DZAI_dynTriggersMax = 3;
	};
	case "zargabad":
	{
		DZAI_centerMarker setMarkerPos [3959.501, 4477.0693];
		DZAI_centerSize = 2750;
		DZAI_dynTriggersMax = 6;
	};
	case "fallujah":
	{
		DZAI_centerMarker setMarkerPos [5139.8008, 4092.6797];
		DZAI_centerSize = 4000;
		DZAI_dynTriggersMax = 13;
	};
	case "takistan":
	{
		DZAI_centerMarker setMarkerPos [7027.8721, 6796.8696];
		DZAI_centerSize = 5500;
		DZAI_dynTriggersMax = 18;
	};
    case "tavi":
    {
		DZAI_centerMarker setMarkerPos [10704.772, 10397.833, 1.5322094];
		DZAI_centerSize = 7000;
		DZAI_dynTriggersMax = 22;
    };
	 case "lingor":
    {
		DZAI_centerMarker setMarkerPos [4393.4473, 4299.8701];
		DZAI_centerSize = 3000;
		DZAI_dynTriggersMax = 10;
    };
    case "namalsk":
    {
		DZAI_centerMarker setMarkerPos [6202.1201, 8695.4121];
		DZAI_centerSize = 3000;
		DZAI_dynTriggersMax = 6;
    };
    case "mbg_celle2":
    {
		DZAI_centerMarker setMarkerPos [6337.6265, 6088.0913];
		DZAI_centerSize = 5500;
		DZAI_dynTriggersMax = 18;
    };
	case "oring":
    {
		DZAI_centerMarker setMarkerPos [5138.3276, 5535.9248];
		DZAI_centerSize = 4000;
		DZAI_dynTriggersMax = 13;
    };
	case "panthera2":
    {
		DZAI_centerMarker setMarkerPos [5517.9404, 4536.2656];
		DZAI_centerSize = 3000;
		DZAI_dynTriggersMax = 10;
    };
	case "isladuala":
    {
		DZAI_centerMarker setMarkerPos [5710.4683, 4782.1729];
		DZAI_centerSize = 3000;
		DZAI_dynTriggersMax = 10;
    };
	case "sara":
	{
		DZAI_centerMarker setMarkerPos [12126.131, 11405.327, 0.036790848];
		DZAI_centerSize = 6000;
		DZAI_dynTriggersMax = 22;
    };
};

if (DZAI_verifyTables) then {["DZAI_Rifles0","DZAI_Rifles1","DZAI_Rifles2","DZAI_Rifles3","DZAI_BanditTypes"] execVM "\z\addons\dayz_server\DZAI\scripts\verifyTables.sqf";};
if (DZAI_dynTriggersMax > 0) then {[DZAI_dynTriggersMax] execVM '\z\addons\dayz_server\DZAI\scripts\spawnTriggers_random.sqf';};
if (DZAI_monitor) then {[] execVM '\z\addons\dayz_server\DZAI\scripts\dzai_monitor.sqf';};
if (DZAI_debugLevel > 0) then {diag_log "[DZAI] DZAI Lite loading complete.";};
