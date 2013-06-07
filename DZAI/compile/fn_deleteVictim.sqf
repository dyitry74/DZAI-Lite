private ["_victim"];

_victim = _this select 0;

sleep DZAI_delDeadTime;

deleteVehicle _victim;
