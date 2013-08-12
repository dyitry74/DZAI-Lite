/*
	DZAI Lite Variables File
	
	Description: Contains all configurable settings of DZAI. Contains settings for debugging, customization of AI units, spawning, and loot.
	
	Last updated: 10:33 PM 8/4/2013
*/
private["_worldname"];

diag_log "[DZAI] Reading DZAI variables.";

//Zombie Hostility
DZAI_zombieEnemy = true;									//Enable or disable AI hostility to zombies. If enabled, AI will attack zombies. (default: true)

//DZAI Settings
DZAI_debugLevel = 0;										//Enable or disable event logging to arma2oaserver.rpt. Debug level setting. 0: Off, 1: Basic Debug, 2: Extended Debug. (Default: 0)
DZAI_debugMarkers = 0;										//Enable or disable debug markers. Track AI position, locate patrol waypoints, locate dynamically-spawned triggers. (Default: 0)
DZAI_monitor = true;										//Enable or disable server monitor. Keeps track of number of max/current AI units and dynamically spawned triggers. (Default: true)
DZAI_monitorRate = 180;										//Frequency of server monitor update to RPT log in seconds. (Default: 180)								
DZAI_verifyTables = true;									//Set 'true' to have DZAI check all classname tables for banned or invalid classnames. (Default: true)
DZAI_objPatch = false;										//(Experimental) Enable to have server spawn in objects/buildings normally spawned clientside by DayZ's CfgTownGenerator. Prevents AI from walking/shooting through clutter and other objects. (Default: false)

//AI Unit Variables						
DZAI_refreshRate = 15;										//Amount of time in seconds between AI ammo and zombie check. (Default: 15)
DZAI_zDetectRange = 200;									//Maximum distance for AI to detect zombies. (Default: 200)

//Dynamic Trigger Settings - DZAI automatically determines the settings for dynamic triggers. Below are settings that can be manually adjusted.
DZAI_dynAISpawns = true;									//Enable or disable dynamic AI trigger spawns. If enabled, AI spawn locations will be randomly placed around the map. (Default: true)
DZAI_dynRemoveDeadWait = 300;								//Time to wait before deleting dead AI corpses. Timer starts when all units in a group have been killed.(Default: 300)
DZAI_dynDespawnWait = 120;									//Time to allow AI to remain in seconds before being removed when all players have left a trigger area. (Default: 120)

//AI Helicopter patrol settings
//IMPORTANT: Before enabling AI helicopter patrols, make sure you have properly edited your server_cleanup.fsm file. Otherwise, the helicopters will explode after spawning.
DZAI_aiHeliPatrols = false;									//Enable or disable AI helicopter patrols. (Default: false)
DZAI_maxHeliPatrols = 0;									//Maximum number of active AI helicopters patrols. (Default: 0).
DZAI_heliTypes = ["UH1H_DZ"];								//Classnames of helicopter types to use. Helicopter types must have at least 2 gunner seats (Default: "UH1H_DZ").
DZAI_heliLoot = true;										//Enable or disable loot generation on destroying AI helicopter. Dead crew members will be parachuted out after helicopter is destroyed (Default: true)

//Extra AI Settings
DZAI_findKiller = false;									//If enabled, AI group will attempt to track down player responsible for killing a group member. Players with radios will be given text warnings if they are being pursued (Default: false)
DZAI_tempNVGs = false;										//If normal probability check for spawning NVGs fails, then give AI temporary NVGs only if they are spawned with weapongrade 2 or 3 (applies only during nighttime hours). Temporary NVGs are unlootable and will be removed at death (Default: false).
DZAI_humanityGain = 0;										//Amount of humanity to reward player for killing an AI unit (Default: 0)

//Dynamic weapon list settings
DZAI_dynamicWeaponList = true;								//True: Dynamically generate AI weapon list from CfgBuildingLoot. False: Use preset weapon list (DayZ 1.7.6.1). Highly recommended to enable DZAI_verifyTables if this option is set to false. (Default: true).
DZAI_banAIWeapons = [];										//(Only if DZAI_dynamicWeaponList = true) List of weapons that AI should never use. By default, AI may carry any lootable weapon. Example: DZAI_banAIWeapons = ["M107_DZ","BAF_AS50_scoped"]; will remove the M107 and AS50 from AI weapon tables  if dynamic weapon list is enabled.
//Note: It is recommended to add all melee weapon classnames into this list as AI have issues using melee weapons. All melee weapons and crossbows present in DayZ 1.7.7.1 have been pre-banned ("Crossbow_DZ","Crossbow","MeleeBaseBallBat","MeleeMachete")

//AI loot probabilities
DZAI_gradeChancesDyn = [0.25,0.65,0.08,0.02];				//Probabilities of generating each weapongrade (0,1,2,3). 0: Civilian, 1: Military, 2: MilitarySpecial, 3: Heli Crash. Weapon grade also influences the general skill level of the AI unit.

//Load custom DZAI settings file.
call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\DZAI_settings_override.sqf";

//AI skill settings
DZAI_skill0 = [	
	//AI skill settings level 0 (Skill, Minimum skill, Maximum bonus amount).
	["aimingAccuracy",0.10,0.10],
	["aimingShake",0.55,0.10],
	["aimingSpeed",0.45,0.10],
	["endurance",0.40,0.20],
	["spotDistance",0.30,0.20],
	["spotTime",0.40,0.20],
	["courage",0.40,0.20],
	["reloadSpeed",0.40,0.20],
	["commanding",0.40,0.20],
	["general",0.40,0.20]
];
DZAI_skill1 = [	
	//AI skill settings level 1 (Skill, Minimum skill, Maximum bonus amount).
	["aimingAccuracy",0.10,0.10],
	["aimingShake",0.65,0.10],
	["aimingSpeed",0.55,0.10],
	["endurance",0.55,0.20],
	["spotDistance",0.45,0.20],
	["spotTime",0.55,0.20],
	["courage",0.55,0.20],
	["reloadSpeed",0.55,0.20],
	["commanding",0.55,0.20],
	["general",0.55,0.20]
];
DZAI_skill2 = [	
	//AI skill settings level 2 (Skill, Minimum skill, Maximum bonus amount).
	["aimingAccuracy",0.20,0.10],
	["aimingShake",0.75,0.10],
	["aimingSpeed",0.70,0.10],
	["endurance",0.70,0.20],
	["spotDistance",0.60,0.20],
	["spotTime",0.70,0.20],
	["courage",0.70,0.20],
	["reloadSpeed",0.70,0.20],
	["commanding",0.70,0.20],
	["general",0.70,0.20]
];
DZAI_skill3 = [	
	//AI skill settings level 3 (Skill, Minimum skill, Maximum bonus amount).
	["aimingAccuracy",0.30,0.10],
	["aimingShake",0.85,0.10],
	["aimingSpeed",0.80,0.10],
	["endurance",0.80,0.20],
	["spotDistance",0.75,0.20],
	["spotTime",0.80,0.20],
	["courage",0.80,0.20],
	["reloadSpeed",0.80,0.20],
	["commanding",0.80,0.20],
	["general",0.80,0.20]
];
DZAI_heliCrewSkills = [	
	//AI skill settings level 4 (Skill, Minimum skill, Maximum bonus amount).
	["aimingAccuracy",0.40,0.10],
	["aimingShake",0.85,0.10],
	["aimingSpeed",0.85,0.10],
	["endurance",0.60,0.20],
	["spotDistance",0.90,0.10],
	["spotTime",0.90,0.10],
	["courage",0.90,0.10],
	["reloadSpeed",0.90,0.10],
	["commanding",0.90,0.10],
	["general",0.90,0.10]
];

//NOTHING TO EDIT BEYOND THIS POINT.

//Internal Use Variables: DO NOT EDIT THESE
DZAI_weaponGrades = [0,1,2,3];								//All possible weapon grades. A "weapon grade" is a tiered classification of gear. 
DZAI_numAIUnits = 0;										//Keep track of currently active AI units, including dead units waiting for respawn.
DZAI_actDynTrigs = 0;										//Keep track of current number of active dynamically-spawned triggers
DZAI_curDynTrigs = 0;										//Keep track of current total of inactive dynamically-spawned triggers.
DZAI_actTrigs = 0;											//Keep track of active static triggers.	
DZAI_dynTriggerArray = [];									//List of current dynamic triggers.	
DZAI_dmgFactors = [0.3375,0.50625,0.3375,1,1];				//AI health settings.
DZAI_curHeliPatrols = 0;									//Tracks current number of active AI heli patrols.
DZAI_heliWaypoints = [];									//Current list of randomly-generated AI heli patrol waypoints.

diag_log "[DZAI] DZAI Variables loaded.";
