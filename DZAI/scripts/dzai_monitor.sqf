/*
	DZAI Lite Server Monitor
	
	Description: Periodically reports current numbers of active AI units and dynamic triggers.
	
	Last updated: 4:24 PM 6/7/2013
*/

diag_log "Starting DZAI Server Monitor in 60 seconds.";
sleep 60;

while {true} do {
	if ((isNil "DZAI_numAIUnits") || (DZAI_numAIUnits < 0)) then {DZAI_numAIUnits = 0; diag_log "DEBUG :: Active AI count has been force reset to zero.";};
	diag_log format ["DZAI Monitor :: %1/%2 (cur/max) active AI units. %3/%4 (active/total) dynamic triggers.",DZAI_numAIUnits,DZAI_maxAIUnits,DZAI_actDynTrigs,DZAI_curDynTrigs];
	sleep DZAI_monitorRate;
};
