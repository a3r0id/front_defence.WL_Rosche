_check_fop = missionNamespace getVariable ["FOP_LOCATION", false];

if !(_check_fop isEqualTo false) then {
	{
		if (_x getVariable ["IS_FOP", false] == true) then {
			deleteVehicle _x;
		};
	} forEach allMissionObjects "";
	[false] call fnc_server_setFopLocation;	
};
