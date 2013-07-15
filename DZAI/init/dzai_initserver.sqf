/*
	DZAI Lite Server Initialization File
	
	Description: Handles startup process for DZAI Lite. Does not contain any values intended for modification.
	
	Last updated: 2:04 PM 7/14/2013
*/
private ["_startTime"];

if (!isServer) exitWith {};

_startTime = diag_tickTime;
#include "DZAI_version.hpp"
diag_log format ["Initializing %1 version %2",DZAI_TYPE,DZAI_VERSION];

createcenter east;							//Create centers for all sides
createcenter resistance;
east setFriend [resistance, 1];								//Resistance (AI) is hostile to West (Player), but friendly to East (AI).
east setFriend [west, 0];	
resistance setFriend [west, 0];								//East (AI) is hostile to West (Player), but friendly to Resistance (AI).
resistance setFriend [east, 1];	
west setFriend [resistance, 0];								//West (Player side) is hostile to all.
west setFriend [east, 0];

//Load DZAI variables
#include "dzai_variables.sqf"

//Load DZAI functions
#include "dzai_functions.sqf"

//Load DZAI classname tables.
#include "base_classname_configs\base_classnames.sqf"

//Build DZAI Lite weapon classname tables from CfgBuildingLoot data.
if (DZAI_dynamicWeaponList) then {[DZAI_banAIWeapons] execVM '\z\addons\dayz_server\DZAI\scripts\buildRifleArrays.sqf';};

//Create reference marker for dynamic triggers and set default values. These values are modified on a per-map basis in the switch-case block below.
_this = createMarker ["DZAI_centerMarker", (getMarkerPos 'center')];
_this setMarkerType "Empty";
_this setMarkerBrush "Solid";
DZAI_centerMarker = _this;
DZAI_dynTriggerRadius = 600;
DZAI_dynOverlap = 0.15;

private["_worldname"];
_worldname=toLower format ["%1",worldName];
diag_log format["[DZAI] Server is running map %1.",_worldname];

switch (_worldname) do {
	case "chernarus":
	{
		DZAI_centerMarker setMarkerPos [7130.0073, 7826.3501];
		DZAI_centerSize = 5500;
		DZAI_dynTriggersMax = 17;
	};
	case "utes":
	{
		DZAI_centerMarker setMarkerPos [3648.311, 3820.9607];
		DZAI_centerSize = 1000;
		DZAI_dynTriggersMax = 3;
	};
	case "zargabad":
	{
		DZAI_centerMarker setMarkerPos [3998.7087, 4120.4692];
		DZAI_centerSize = 2000;
		DZAI_dynTriggersMax = 6;
	};
	case "fallujah":
	{
		DZAI_centerMarker setMarkerPos [5139.8008, 4092.6797];
		DZAI_centerSize = 4000;
		DZAI_dynTriggersMax = 12;
	};
	case "takistan":
	{
		DZAI_centerMarker setMarkerPos [6368.2764, 6624.2744];
		DZAI_centerSize = 6000;
		DZAI_dynTriggersMax = 18;
	};
    case "tavi":
    {
		DZAI_centerMarker setMarkerPos [10864.419, 11084.657, 1.5322094];
		DZAI_centerSize = 8000;
		DZAI_dynTriggersMax = 18;
    };
	 case "lingor":
    {
		DZAI_centerMarker setMarkerPos [4247.3218, 4689.731];
		DZAI_centerSize = 4000;
		DZAI_dynTriggersMax = 12;
    };
    case "namalsk":
    {
		DZAI_centerMarker setMarkerPos [6051.7534, 8728.8447];
		DZAI_centerSize = 3500;
		DZAI_dynTriggersMax = 7;
    };
    case "mbg_celle2":
    {
		DZAI_centerMarker setMarkerPos [6399.5469, 6583.6987];
		DZAI_centerSize = 6250;
		DZAI_dynTriggersMax = 19;
    };
	case "oring":
    {
		DZAI_centerMarker setMarkerPos [5138.3276, 5535.9248];
		DZAI_centerSize = 4750;
		DZAI_dynTriggersMax = 15;
    };
	case "panthera2":
    {
		DZAI_centerMarker setMarkerPos [5510.7402, 4248.1196];
		DZAI_centerSize = 3250;
		DZAI_dynTriggersMax = 10;
    };
	case "isladuala":
    {
		DZAI_centerMarker setMarkerPos [5133.2119, 5228.4541];
		DZAI_centerSize = 5500;
		DZAI_dynTriggersMax = 17;
    };
	case "sara":
	{
		DZAI_centerMarker setMarkerPos [12011.185, 11251.99, 0.036790848];
		DZAI_centerSize = 6250;
		DZAI_dynTriggersMax = 19;
    };
	case default
	{
		DZAI_centerSize = 7000;
		DZAI_dynTriggersMax = 15;
	};
};

//Initialize AI settings
if (isNil "DDOPP_taser_handleHit") then {DZAI_taserAI = false;} else {DZAI_taserAI = true;diag_log "[DZAI] DDOPP Taser Mod detected.";};

if (DZAI_verifyTables) then {["DZAI_Rifles0","DZAI_Rifles1","DZAI_Rifles2","DZAI_Rifles3","DZAI_BanditTypes"] execVM "\z\addons\dayz_server\DZAI\scripts\verifyTables.sqf";};
if (DZAI_dynAISpawns || DZAI_aiHeliPatrols) then {[] execVM '\z\addons\dayz_server\DZAI\scripts\DZAI_scheduler.sqf';};
if (DZAI_monitor) then {[] execVM '\z\addons\dayz_server\DZAI\scripts\DZAI_monitor.sqf';};

diag_log format ["[DZAI] DZAI loading completed in %1 seconds.",(diag_tickTime - _startTime)];
diag_log format ["[DZAI] DZAI Variables loaded. Debug Level: %1. DebugMarkers: %2. DZAI_dynamicWeaponList: %3. VerifyTables: %4.",DZAI_debugLevel,DZAI_debugMarkers,DZAI_dynamicWeaponList,DZAI_verifyTables];
