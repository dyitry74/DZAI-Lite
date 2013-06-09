DZAI Lite 0.0.4 - AI Addon for DayZ
============


Introduction
============

DZAI Lite is a simplified version of the DZAI addon that retains the dynamic spawn trigger system while removing all static triggers and any unnecessary functions.

Summary of simplifications made in DZAI Lite:

- AI do not carry any "extra" equipment (ie: pistols, consumable items). AI units will only carry a primary weapon, single magazine, backpack, and possibly Binoculars or NVGs.
- No extra configuration files used for each map - DZAI Lite uses a single universal config file. To ensure compatibility with all maps, the classname verification option has been enabled by default.
- No static AI spawns - gameplay in cities and towns is uninterrupted by AI.
- Heavily reduced file size (DZAI: 440KB vs DZAI Lite: 76.7KB)

Installation Instructions:
============
- Unpack your <b>dayz_server.pbo</b>
- Copy the new DZAI folder inside your unpacked dayz_server folder. (You should also see config.cpp in the same level.)
- Edit your <b>server_monitor.sqf</b>. It is located within \dayz_server\system. 
- Locate the line that reads: <code>// # END OF STREAMING #</code> (Located near line 174. Exact location depends on your DayZ server software).
- Underneath this line, insert the following (If reading this in a text editor, ignore the code tags!): <code>call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\init\dzai_initserver.sqf";</code>. Refer to the provided example server_monitor.sqf (named server_monitor_example.sqf)
- Repack your dayz_server.pbo.
- You are now ready to start your server.

Latest Updates:
============

0.0.1 (Initial release):

- Initial release of DZAI Lite based on DZAI version 0.9.5
- Changes in equipType/weapongrade tiered system are planned.

0.0.2 update:

- [FIXED] Debug markers for patrol waypoints are now properly removed when AI units are despawned.
- [FIXED] Dynamic triggers no longer remain active due to player presence if all AI units in the area have been killed. Despawn process is forced 2 minutes after the last AI unit in the area is killed.
- [REMOVED] Removed fn_getGradeChances.sqf with the removal of the equipType classification system.
- [MODIFIED] DZAI_gradeChances0-3 tables have been simplified into a single DZAI_gradeChances table.

0.0.3 update:

- [NEW] Number of AI spawned per trigger is now dependent on the number of players present in the trigger instead of being configured. (minimum of 2 to maximum of 6, +/- 1)
- [REMOVED] AI no longer carry backpacks.
- [MODIFIED] Lowered chance of generating NVGs in high tier tools table from 25% to 20%.
- [MODIFIED] Dynamic trigger activation timings changed from 5/7/10 seconds to 5/10/15 seconds.

0.0.4 update:

- [FIXED] Removed all remaining variables relating to minimum/additional AI to spawn for dynamic triggers.
- [REMOVED] Dynamic trigger spawning script no longer avoids player positions.
- [MODIFIED] Chernarus: adjusted spawning range of dynamic triggers from 5250m to 6000m. Increased number of dynamic triggers from 20 to 22.
- [MODIFIED] Spawning range of AI from dynamic triggers increased from 125m (+125m max) to 125m (+175m max).
- [MODIFIED] Dynamic trigger activation timings changed from 5/10/15 seconds to 5/10/30 seconds.
