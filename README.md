DZAI Lite 0.1.9.1 - AI Addon for DayZ
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

- Unpack your <b>dayz_server.pbo</b>
- Copy the new DZAI folder inside your unpacked dayz_server folder. (You should also see config.cpp in the same level.)
- Edit your <b>server_monitor.sqf</b>. It is located within \dayz_server\system. 
- Locate the line that reads: <code>waituntil{isNil "sm_done"}; // prevent server_monitor be called twice (bug during login of the first player)</code> (located near line 200). If this line can't be located, find the one that reads: <code>// # END OF STREAMING #</code> (Located near line 174).
- Underneath this line, insert the following (If reading this in a text editor, ignore the code tags!): <code>call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\init\dzai_initserver.sqf";</code>. Refer to the provided example server_monitor.sqf (named server_monitor_example.sqf)
- Read the section below on other required edits and follow the instructions.
- Repack your dayz_server.pbo (it should be about 400KB larger).
- You are now ready to start your server.

Note: DZAI Lite's settings file can be found in DZAI\init\dzai_variables.sqf

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

0.1.8 Update:

- [NEW] Humanity can now be awarded to players for AI unit kills. Humanity rewarded can be edited in DZAI_variables.sqf.
- [NEW] Added DZAI Scheduler to manage all scheduled tasks.
- [NEW] Added prototype version of AI helicopter patrols feature, which can be enabled in DZAI_variables.sqf. Helicopter patrols require edits to server_cleanup.fsm. Instructions have been provided in the Required Edits section. More details on the helicopters feature here: http://opendayz.net/threads/release-dzai-lite-dynamic-ai-package.11116/page-8#post-61128.
- [FIXED] Fixed error that prevented Radio text messages from being displayed to player when dynamic AI have ended their pursuit state.
- [UPDATED] SHK_pos package included with DZAI is now only initialized if it is not already started.
- [UPDATED] Updated DZAI Server Monitor output. Text output is now separated into overall server statistics (uptime, AI count), dynamic AI statistics.
- [MODIFIED] Locations of debug markers for dynamic triggers are now refreshed at an interval specified by DZAI_monitorRate.
- [MODIFIED] Renamed several script files, some added directly into DZAI_functions.sqf
- [MODIFIED] Maximum dynamic trigger area overlap tolerance increased to 15% from 10%.

0.1.9 Update:

- [FIXED] AI self-healing now heals damage properly.
- [UPDATED] Added a check if DZAI is already running to prevent multiple instances of DZAI from starting.
- [UPDATED] Setting debugMarkers = 2 will enable continuous refreshing of dynamic trigger locations. (Setting value to 1 will disable these markers but other debug marker functionalities remain).
- [MODIFIED] Increased AI helicopter crew skills.
- [MODIFIED] Increased AI health. Note: Due to the differences between how AI and player health is calculated, AI units may be more or less durable than player units.
- [MODIFIED] Adjusted minimum AI helicopter flying height to 90m.

0.1.9.1 Hotfix:

- [FIXED] Fixed AI HandleDamage eventhandler functionality with DDOPP Taser Mod. (AI units should have improved durability even with the Taser mod installed).

0.1.9.2 Minor Update:

- [UPDATED] Nearby zeds are revealed to AI groups to help reduce time required to recognize marked zeds as hostile.
- [MODIFIED] Scaled back AI health increases slightly. (2 DMR body shots to body should kill an AI unit)

Note: Older updates are archived in changelog.txt
