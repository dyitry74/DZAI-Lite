/*
	Description: Basic tables containing AI equipment classnames and skin models used by AI units.

	Last upated: 11:41 PM 6/11/2013
*/

	if !(DZAI_dynamicWeaponList) then {
		//If dynamic weapon list is disabled, then use preset tables. This method is faster than dynamic generation, but compatibility issues may arise.
		//If using any DayZ map other than Chernarus, it is *highly* recommended to set DZAI_verifyTables = true; to avoid compatibility issues.
		diag_log "Loading preset weapon list.";
		DZAI_Pistols0 = ["Makarov","Colt1911","revolver_EP1","Makarov","Colt1911","revolver_EP1"];
		DZAI_Pistols1 = ["M9","M9SD","UZI_EP1","glock17_EP1"];
		DZAI_Pistols2 = ["M9SD","UZI_EP1","glock17_EP1"];
		DZAI_Pistols3 = ["M9SD","UZI_EP1","glock17_EP1"];
		DZAI_Rifles0 = ["LeeEnfield","Winchester1866","MR43","huntingrifle","LeeEnfield","Winchester1866","MR43","LeeEnfield","Winchester1866","MR43","Makarov","Colt1911","revolver_EP1","Makarov","Colt1911","revolver_EP1"];
		DZAI_Rifles1 = ["M16A2","M16A2GL","AK_74","M4A1_Aim","AKS_74_kobra","AKS_74_U","AK_47_M","M24","M1014","DMR","M4A1","M14_EP1","Remington870_lamp","MP5A5","MP5SD","M4A3_CCO_EP1","Sa58P_EP1","Sa58V_EP1","BAF_L85A2_RIS_Holo"];
		DZAI_Rifles2 = ["M16A2","M16A2GL","M249_DZ","AK_74","M4A1_Aim","AKS_74_kobra","AKS_74_U","AK_47_M","M24","SVD_CAMO","M1014","DMR","M4A1","M14_EP1","Remington870_lamp","M240_DZ","M4A1_AIM_SD_camo","M16A4_ACG","M4A1_HWS_GL_camo","Mk_48_DZ","M4A3_CCO_EP1","Sa58V_RCO_EP1","Sa58V_CCO_EP1","M40A3"];
		DZAI_Rifles3 = ["FN_FAL","bizon_silenced","M14_EP1","FN_FAL_ANPVS4","Mk_48_DZ","M249_DZ","BAF_L85A2_RIS_SUSAT","DMR","G36C","G36C_camo","G36A_camo","G36K_camo"];
		DZAI_weaponsInitialized = true;
	};

	DZAI_BanditTypes = ["Survivor2_DZ", "SurvivorW2_DZ", "Bandit1_DZ", "BanditW1_DZ", "Camo1_DZ", "Sniper1_DZ"]; //List of skins for AI units to use

	DZAI_gadgets0 = [["binocular",0.70],["NVGoggles",0.005]];	//Gadgets (and probabilities) for AI with weapongrade 0-1
	DZAI_gadgets1 = [["binocular",0.95],["NVGoggles",0.15]];	//Gadgets (and probabilities) for AI with weapongrade 2-3
	
	diag_log "DZAI base classname tables loaded.";
