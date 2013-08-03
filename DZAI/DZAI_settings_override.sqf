/*
	DZAI User-Specified Settings File
	
	Description: 	Use this file to store your preferred settings. The variables stored in this file will override DZAI's default settings in DZAI\init\dzai_variables.sqf.
					This file will not be changed after each DZAI update, so it is a convenient place to store your custom settings. 
					
	Instructions:	Copy over the lines from DZAI\init\dzai_variables.sqf containing the setting(s) that you wish to keep after each DZAI update.
					Whenever you update to a newer version of DZAI, overwrite the default DZAI_settings file with your edited copy.
	
	Reminder: Remember to check if anything has changed in the dzai_variables.sqf file after each update to DZAI.
	
	Example: If you always want your server to have helicopters enabled with a maximum of 5 helicopters, and using the UH1H and Mi17, then the contents of this file would look like this:
	
	-------------------------(Begin Example File)-------------------------
	
	//Comment out the line below to have DZAI read from this file.
	//if (isNil "DZAI_Use_Default_Settings") exitWith {};
	
	//Add your preferred settings below this line.
	DZAI_aiHeliPatrols = true;									//Enable or disable AI helicopter patrols. (Default: false)
	DZAI_maxHeliPatrols = 5;									//Maximum number of active AI helicopters patrols. (Default: 0).
	DZAI_heliTypes = ["UH1H_DZ","Mi17_DZ"];						//Classnames of helicopter types to use. Helicopter types must have at least 2 gunner seats (Default: "UH1H_DZ").

	-------------------------(End of Example File)-------------------------
*/

//Comment out the line below to have DZAI read from this file.
//if (isNil "DZAI_Use_Default_Settings") exitWith {};

//Add your preferred settings below this line.
DZAI_debugLevel = 2;										//Enable or disable event logging to arma2oaserver.rpt. Debug level setting. 0: Off, 1: Basic Debug, 2: Extended Debug. (Default: 0)
DZAI_debugMarkers = 2;										//Enable or disable debug markers. 0: Off, 1: Basic markers (Track AI position, locate patrol waypoints, locate dynamically-spawned triggers), 2: Extended markers (Basic markers + Static trigger markers and refreshing dynamic trigger markers) (Default: 0)
DZAI_monitor = true;										//Enable or disable server monitor. Periodically reports number of max/current AI units and dynamically spawned triggers into RPT log. (Default: true)
DZAI_monitorRate = 30;										//Frequency of server monitor update to RPT log in seconds. (Default: 180)
DZAI_aiHeliPatrols = true;									//Enable or disable AI helicopter patrols. (Default: false)
DZAI_maxHeliPatrols = 4;									//Maximum number of active AI helicopters patrols. (Default: 0).
DZAI_heliTypes = ["UH1H_DZ","Mi17_DZ"];						//Classnames of helicopter types to use. Helicopter types must have at least 2 gunner seats (Default: "UH1H_DZ").
DZAI_findKiller = true;										//If enabled, AI group will attempt to track down player responsible for killing a group member. Players with radios will be given text warnings if they are being pursued (Default: false)
