/*
	Description: Basic tables containing AI equipment classnames and skin models used by AI units. Some settings may be overridden by map-specific configuration files in the loot_configs folder.
				Also contains stripped-down tables for Safe Mode setting.
	
	Important Notes: EDIT WITH CARE - these tables affect ALL DayZ mods globally. 
	To make changes for a specific DayZ mod, edit the appropriate config file in configs folder. 
	Rule of thumb: If it doesn't belong in the original DayZ mod, it doesn't belong here. Edit the mod-specific config file instead.
	
	Last upated: 6/3/2013
*/

	DZAI_BanditTypesDefault = ["Survivor2_DZ", "SurvivorW2_DZ", "Bandit1_DZ", "BanditW1_DZ", "Camo1_DZ", "Sniper1_DZ"]; //List of skins for AI units to use

	DZAI_RiflesDefault0 = ["Winchester1866", "LeeEnfield", "huntingrifle","MR43"];
	DZAI_RiflesDefault1 = ["M16A2","M16A2GL","AK_74","M4A1_Aim","AKS_74_kobra","AKS_74_U","AK_47_M","M24","M1014","DMR","M4A1","M14_EP1","Remington870_lamp","MP5A5","MP5SD","M4A3_CCO_EP1","Sa58P_EP1","Sa58V_EP1","BAF_L85A2_RIS_Holo"];
	DZAI_RiflesDefault2 = ["M16A2","M16A2GL","M249_DZ","AK_74","M4A1_Aim","AKS_74_kobra","AKS_74_U","AK_47_M","M24","SVD_CAMO","M1014","M107_DZ","DMR","M4A1","M14_EP1","Remington870_lamp","M240_DZ","M4A1_AIM_SD_camo","M16A4_ACG","M4A1_HWS_GL_camo","Mk_48_DZ","M4A3_CCO_EP1","Sa58V_RCO_EP1","Sa58V_CCO_EP1","M40A3"];
	DZAI_RiflesDefault3 = ["FN_FAL","bizon_silenced","M14_EP1","FN_FAL_ANPVS4","M107_DZ","BAF_AS50_scoped","Mk_48_DZ","M249_DZ","DMR","G36C","G36C_camo","G36A_camo","G36K_camo","BAF_L85A2_RIS_SUSAT"]; //+ ["RPK_74"]; For DayZ 1.7.7

	DZAI_Backpacks0 = ["DZ_Patrol_Pack_EP1","DZ_Assault_Pack_EP1","DZ_Czech_Vest_Puch"];
	DZAI_Backpacks1 = ["DZ_Czech_Vest_Puch","DZ_Assault_Pack_EP1","DZ_British_ACU","DZ_TK_Assault_Pack_EP1","DZ_CivilBackpack_EP1","DZ_ALICE_Pack_EP1"];
	DZAI_Backpacks2 = ["DZ_CivilBackpack_EP1","DZ_ALICE_Pack_EP1","DZ_Backpack_EP1"];
	DZAI_Backpacks3 = ["DZ_Backpack_EP1"];

	DZAI_gadgets0 = [["binocular",0.70],["NVGoggles",0.005]];
	DZAI_gadgets1 = [["binocular",0.95],["NVGoggles",0.33]];
	
	diag_log "DZAI default loot tables loaded.";
