DZAI Lite 0.2.0 - AI Addon for DayZ
============


Introduction
============

DZAI Lite is a simplified version of the DZAI addon (https://github.com/dayzai/DayZBanditAI) that retains the dynamic spawn trigger system while removing all static triggers and any unnecessary functions.

Summary of simplifications made in DZAI Lite:

- AI do not carry any "extra" equipment (ie: pistols, consumable items). AI units will only carry a primary weapon, single magazine, and possibly Binoculars or NVGs.
- No extra configuration files used for each map - DZAI Lite uses a single universal config file. To ensure compatibility with all maps, the classname verification option has been enabled by default.
- No static AI spawns - gameplay in cities and towns is mostly uninterrupted by AI.
- Heavily reduced file size.
- Less settings to manually configure, many settings are automatically handled. Simply install and run.

Features
============

- Installed to your server's dayz_server.pbo - nothing is downloaded or run on clients.
- Automatically builds a list of weapons that AI can use by reading DayZ's CfgBuildingLoot. This means that AI units may carry any lootable weapon.
- AI spawning is completely dynamic and automatically generated - there is no need to manually add spawn points.
- AI spawn points with no players nearby will periodically relocate themselves around the map area, so there is no predicting where AI will show up next.
- The number of AI spawned is dependent on the number of players within the trigger area, so the difficulty is self-adjusting. The more populated the area is, the more AI that will spawn in. (Minimum of 2±1 to a maximum of 6±1)
- The AI despawn when there are no players in the area, or some time after they are killed.

Installation Instructions:
============
<b>IMPORTANT</b>: The AI helicopter patrols feature requires edits to your server_cleanup.fsm. Failure to edit this file properly will cause helicopters spawned by DZAI to explode. Instructions are provided in the Required Edits section below.
- (Only do this if you have an older version of DZAI installed in your mission file): Delete the DZAI folder inside your mission file and remove the reference to DZAI in your init.sqf. Repack your mission pbo <b>without</b> DZAI.
- Unpack your <b>dayz_server.pbo</b>
- Copy the new DZAI folder inside your unpacked dayz_server folder. (You should also see config.cpp in the same level.)
- Edit your <b>server_monitor.sqf</b>. It is located within \dayz_server\system. 
- Search for the line where server_cleanup.fsm is called, and insert the following after this line:


    <code>call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\init\dzai_initserver.sqf";</code>


An example is shown here:

    if (isDedicated) then {
        _id = [] execFSM "\z\addons\dayz_server\system\server_cleanup.fsm";
        call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\init\dzai_initserver.sqf";
    };

	
- <b>NOTE:</b> Certain DayZ mods such as DayZ Epoch do not have a server_cleanup.fsm reference. In this case, insert the required line before the line that says:

    <code>allowConnection = true;</code>

- Read the section below on other required edits and follow the instructions.
- Repack your dayz_server.pbo.
- You are now ready to start your server.

<b>Note:</b> DZAI's settings file can be found in DZAI\init\dzai_variables.sqf. You may store your custom settings changes in DZAI\DZAI_settings_override.sqf. Instructions are provided inside this file.

Required Edits:
============

<b>server_cleanup.fsm:</b>
In order to use DZAI's AI helicopter patrols, you must first edit your server_cleanup.fsm located in dayz_server\system. Locate this line in server_cleanup.fsm:


	"  	if(vehicle _x != _x && !(vehicle _x in _safety) && (typeOf vehicle _x) != ""ParachuteWest"") then {" \n

	
If you <b>do not</b> have the Animated Helicopters addon installed, change the line to this :


	"  	if(vehicle _x != _x && !(vehicle _x in _safety) && (typeOf vehicle _x) != ""ParachuteWest"" && (vehicle _x getVariable [""DZAI"",0] != 1)) then {" \n
 
 
If you <b>do</b> have the Animated Helicopters addon installed, change the line to this:


	"  	if(vehicle _x != _x && !(vehicle _x in _safety) && (typeOf vehicle _x) != ""ParachuteWest"" && ((vehicle _x getVariable [""Sarge"",0] != 1) && (vehicle _x getVariable [""DZAI"",0] != 1))) then {" \n


Troubleshooting Instructions:
============

DZAI Lite is designed with maximum compatibility in mind, but unforseen problems may occur.

Q1: How can I check if DZAI Lite is generating AI spawn points, or verify that AI are properly spawning?

A1: Open dzai_variables.sqf - it is located in \DZAI\init. Set DZAI_debugMarkers to 1. In your ingame map, you will see circular markers indicating the trigger areas. If you enter these trigger areas, the circular marker will change from yellow to orange to show that the trigger is active. Small red dots will indicate positions of AI units, and blue dots will indicate their waypoints. Setting DZAI_debugLevel to 1 or 2 will also allow DZAI to output relevant details into your RPT log.


Q2: The AI aren't carrying any weapons!

A2: This may happen if the DayZ mod uses non-standard names for their loot tables, or if DayZ's loot table structure has changed. In this case, set DZAI_dynamicWeaponList to false to have DZAI use backup weapon lists instead. Also, make sure you set DZAI_verifyTables to true to ensure all classnames are compatible with your DayZ mod.


Q3: A new DayZ map has been released, will DZAI Lite support it?

A3: DZAI reads DayZ's loot tables to find weapon classnames, followed by a verification procedure to make sure they are not banned or invalid. This method allows DZAI to adapt itself to any DayZ map. 
	DZAI will also use DayZ's 'center' marker as a reference point to generate dynamic triggers to spawn AI if an unrecognized map is used. Note: I will only update DZAI to specifically support DayZ maps/mods with publicly-available server files.


Latest Updates:
============

0.2 Update

- [NEW] AI units can now be knocked unconscious upon taking heavy damage (10 seconds). Headshots cause unconsciousness more easily. Note: AI helicopter crew units cannot be knocked unconscious.
- [NEW] AI hands and legs can be broken in the same way as players (same damage thesholds).
- [NEW] AI helicopters now eject three dead AI units in parachutes after being destroyed. These units carry military-grade gear. No units will be ejected if the helicopter is destroyed over water.
- [NEW] Server admins can now store their custom settings in DZAI\DZAI_settings_override.sqf for reuse. Copy over the settings from DZAI\init\dzai_variables.sqf that you wish to keep to DZAI_settings_override.sqf. Keep this file when upgrading DZAI to newer versions.
- [UPDATED] Changes to unit spawn positioning now allows AI to be spawned in tighter quarters, such as in between buildings and inside forests.
- [UPDATED] Collision damage to AI units reduced to 10% to prevent accidental deaths due to falling off tall objects.
- [REMOVED] Zombies around AI group leaders are no longer automatically revealed to the group.
- [UPDATED] AI helicopters have a 25% chance of entering "Seek and Destroy" mode after reaching a waypoint, where the helicopter will attempt to visually search the area for enemy units (players). S.A.D. mode lasts for 30/60/90 seconds (minimum/average/maximum).
- [UPDATED] Dynamic triggers now relocate instead of spawning AI if activated over water.
- [FIXED] Patrol waypoints are no longer generated in water positions.
- [FIXED] Dynamic triggers that have active spawned AI will not be relocated.
- [FIXED] Targeted player seeking for dynamic AI should now work properly.
- [MODIFIED] Examing dead AI bodies now shows skin classname of AI unit instead of displaying "DZAI Unit"
- [MODIFIED] Dynamic AI pursuit distance increased from 200m to 300m from targeted player's initial position.
- [MODIFIED] Scaled back AI health increases slightly. AI hands and legs take full damage.
- [MODIFIED] Increased number of AI bandages (self-heals) from 2 to 3.
- [MODIFIED] Increased time required for AI self-heal from 3 seconds to 3.5 seconds.
- [MODIFIED] Increased minimum number of AI helicopter patrol waypoints from 10 to 15.

Note: Older updates are archived in changelog.txt
