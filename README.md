DZAI Lite 0.2.1 - AI Addon for DayZ
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
- The number of AI spawned is dependent on the number of players within the trigger area, so the difficulty is self-adjusting. The more populated the area is, the more AI that will spawn in. (Minimum of 1±2 to a maximum of 6)
- The AI despawn when there are no players in the area, or some time after they are killed.

Installation Instructions:
============
1. Unpack your dayz_server.pbo. If using cpbo, right click dayz_server.pbo and click "Extract".
2. Copy the downloaded DZAI folder inside your unpacked dayz_server folder.
3. Edit server_monitor.sqf with a text editor. It is located in \dayz_server\system.
4. Search for the line that says:

		allowConnection = true;

	Change the line to this:

		call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\init\dzai_initserver.sqf";
		allowConnection = true;
	
5. If you do not wish to use DZAI's AI helicopter patrols, you may skip this step. Otherwise, continue reading.
	
	Edit your server_cleanup.fsm (located in \dayz_server\system). Search for this line: 

		"  	if(vehicle _x != _x && !(vehicle _x in _safety) && (typeOf vehicle _x) != ""ParachuteWest"") then {" \n

		
	If you <b>do not</b> have the Animated HeliCrash addon installed, change the line to this :


		"  	if(vehicle _x != _x && !(vehicle _x in _safety) && (typeOf vehicle _x) != ""ParachuteWest"" && (vehicle _x getVariable [""DZAI"",0] != 1)) then {" \n
	 
	 
	If you <b>do</b> have the Animated HeliCrash addon installed, change the line to this:


		"  	if(vehicle _x != _x && !(vehicle _x in _safety) && (typeOf vehicle _x) != ""ParachuteWest"" && ((vehicle _x getVariable [""Sarge"",0] != 1) && (vehicle _x getVariable [""DZAI"",0] != 1))) then {" \n

		
6. Optionally, you may edit DZAI's settings in dayz_server\DZAI\init\dzai_variables.sqf

7. Repack your dayz_server.pbo by right-clicking the unpacked folder, then click on "create PBO". If prompted to overwrite, click "Yes".

Note: You may store your custom settings changes in DZAI\DZAI_settings_override.sqf. This file is a convenient way to store and transfer your custom settings when upgrading to a newer version of DZAI. Further instructions are provided inside this file.

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

0.2.1 Update (Re-release):

- [FIXED] Added an optional experimental fix to prevent AI units from shooting/walking through buildings and objects spawned by DayZ's CfgTownGenerator. Enable by setting DZAI_objectPatch = true in dzai_variables.sqf. Enabling this setting may be essential for DayZ Overwatch 0.2.2+.
<b>Note</b>: Enabling DZAI_objectPatch *may* cause a flood of "Ref to nonnetwork object" errors in your RPT log. This is a harmless warning message but can be annoying as it fills up the RPT log.

Note: Older updates are archived in changelog.txt
