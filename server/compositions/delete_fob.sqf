_check_fob = missionNamespace getVariable ["FOB_LOCATION", false];

if !(_check_fob isEqualTo false) then {
	{
		if ( (_x getVariable ["IS_FOB", false] == true) && !(_x isEqualTo FOB_TELEPORTER)) then {
			deleteVehicle _x;
		};
	} forEach allMissionObjects "";
	[false] call fnc_server_setFobLocation;	
};
