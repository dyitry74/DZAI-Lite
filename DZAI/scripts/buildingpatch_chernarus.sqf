/*
	Spawns objects serverside that are created clientside by DayZ's Town Generator.
	
	Last updated: 10:32 PM 8/4/2013
*/
private["_objClassnames","_objPositions","_startTime"];

if (!isServer) exitWith {};

_startTime = diag_tickTime;

_objClassnames = [	
					"USMC_WarfareBFieldhHospital",
					"CampEast_EP1",
					"Camp",
					"CampEast",
					"Land_fortified_nest_big",
					"Land_fortified_nest_small",
					"Land_Misc_deerstand",
					"Land_Misc_Cargo1Eo_EP1",
					"Fence_corrugated_plate",
					"Land_tent_east",
					"Land_GuardShed",
					"Misc_Cargo1Bo_military",
					"RU_WarfareBBarracks",
					"Land_Toilet",
					"Land_Misc_GContainer_Big",
					"Misc_palletsfoiled_heap"
				];
				
_objPositions = [
	//USMC_WarfareBFieldhHospital
	[
		[313,[6767.52, 2762.48, 0]],
		[42,[6770.4, 2739.77, 0]]
	],	
	
	//CampEast_EP1
	[
		[42,[6746.89, 2784.08, 0]],
		[42,[6757.55, 2776.1, 0]]
	],
	
	//Camp
	[
		[36,[6302.78, 7796.63, 0]],
		[37,[6308.41, 7792.74, 0]],
		[36,[6314, 7788.65, 0]],
		[213,[6312.84, 7805.57, 0]],
		[33,[6319.54, 7784.91, 0]],
		[212,[6318.92, 7801.74, 0]],
		[33,[6325.31, 7781.19, 0]],
		[212,[6325.1, 7798.06, 0]],
		[30,[6331.19, 7777.51, 0]],
		[211,[6331.25, 7794.36, 0]],
		[213,[6337.11, 7790.99, 0]],
		[212,[6349.45, 7783.62, 0]]
	],
	
	//CampEast
	[
		[42,[6746.89, 2784.08, 0]],
		[42,[6757.55, 2776.1, 0]],
		[127,[6295.02, 7800.98, 0]],
		[128,[6305.61, 7810.76, 0]],
		[13,[12213, 9734.75, 0]],
		[13,[12273.1, 9724.66, 0]],
		[13,[12220.8, 9758.06, 0]],
		[13,[12249.2, 9752.89, 0]]
	],

	//Land_fortified_nest_big
	[
		[229,[11989.6, 9185.03, 0]]
	],
	
	//Land_fortified_nest_small
	[
		[42,[6539.75, 2637.61, 0]],
		[51,[6846.47, 2458.95, 0]],
		[40,[11919.3, 9088.24, 0]]
	],
	
	//Land_Misc_deerstand
	[
		[125,[4862.22, 2287.81, 0]],
		[125,[4841.69, 2258.74, 0]],
		[310,[4933.25, 2236.43, 0]],
		[300,[4912.54, 2209.47, 0]],
		[99,[11837.1, 9405.64, 0]],
		[295,[12432.6, 9287.22, 0]]
	],
	
	//Land_Misc_Cargo1Eo_EP1
	[
		[350,[4781.01, 2568.49, 0]],
		[56,[4798.27, 2578.94, 0]],
		[326,[4751.33, 2578.09, 0]]
	],
	
	//Fence_corrugated_plate
	[
		[37,[4902.73, 2247.46, 0]],
		[35,[6317.25, 7824.73, 0]],
		[35,[6319.57, 7823.11, 0]],
		[35,[6322.52, 7821.03, 0]],
		[35,[6325.08, 7819.25, 0]],
		[35,[6328.02, 7817.19, 0]],
		[35,[6330.58, 7815.4, 0]],
		[35,[6333.28, 7813.51, 0]],
		[35,[6335.07, 7812.33, 0]],
		[209,[6338.17, 7810.49, 0]],
		[238,[6341.17, 7808.2, 0]],
		[228,[6342.19, 7808.55, 0]],
		[33,[6344, 7808.59, 0]],
		[33,[6344.5, 7809.53, 0]],
		[33,[6345.11, 7810.09, 0]],
		[33,[6345.88, 7810.9, 0]]
	],
	
	//Land_tent_east
	[
		[217,[4863.82, 2274.84, 0]],
		[217,[4874.83, 2267.48, 0]],
		[217,[4855.34, 2262.99, 0]],
		[217,[11940.6, 9095, 0]]
	],
	
	//Land_GuardShed
	[
		[306,[4924.02, 2222.51, 0]],
		[306,[4928.72, 2219.37, 0]],
		[306,[4933.11, 2215.88, 0]]
	],
	
	//Misc_Cargo1Bo_military
	[
		[129,[4778.78, 2590.21, 0]],
		[298,[4680.98, 2602.59, 0]]
	],
	
	//RU_WarfareBBarracks
	[
		[127,[4913.5, 2241.41, 0]]
	],
	
	//Land_Toilet
	[
		[299,[4902.83, 2248.38, 0]],
		[32,[6353.54, 7781.55, 0]],
		[32,[6354.75, 7780.9, 0]],
		[32,[6355.89, 7780.34, 0]],
		[32,[6357.09, 7779.68, 0]]
	],
	
	//Land_Misc_GContainer_Big
	[
		[304,[6313.24, 7844.13, 0]],
		[304,[6316.67, 7841.9, 0]],
		[304,[6320.43, 7839.67, 0]]
	],
	
	//Misc_palletsfoiled_heap
	[
		[204,[6338.89, 7772.14, 0]],
		[326,[12282.3, 9459.2, 0]],
		[326,[12281.9, 9465.38, 0]],
		[326,[12287.7, 9463.44, 0]],
		[326,[12287.5, 9469.05, 0]],
		[265,[12256.5, 9731.17, 0]]
	]
];

for "_i" from 0 to ((count _objClassnames) - 1) do {
	private ["_objType"];
	_objType = _objClassnames select _i;
	{
		private ["_dir","_pos","_object"];
		_dir = _x select 0;
		_pos =  _x select 1;
		
		_object = _objType createVehicleLocal _pos;
		_object setPosATL _pos;
		_object setDir _dir;
		_object allowDamage false;
		//diag_log format ["DEBUG :: Created serverside object %1 at %2.",_objType,_pos];
		sleep 0.005;
	} forEach (_objPositions select _i);
};

diag_log format ["[DZAI] Serverside object patch completed in %1 seconds.",(diag_tickTime - _startTime)];
