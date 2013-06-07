DZAI Lite Version 0.0.1 - AI Addon for DayZ
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

Version 0.0.1:

- Initial release of DZAI Lite based on DZAI version 0.9.5
- Changes in equipType/weapongrade tiered system are planned.