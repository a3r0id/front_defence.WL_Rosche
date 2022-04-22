// Get median pos of blufor and spawn civis, if any civi is far away from the median, spawn a new one or move civi closer to the median
_front = missionNamespace getVariable ["FRONT_POS", []];
_bf_distance = missionNamespace getVariable ["BLUFOR_DISTANCE", 500];

if (count _front < 1) exitWith {
	systemChat "No FRONT_POS found, aborting civilian-manager for now...";
};


opmerc_civilians = [
	"RDS_Worker4",
	"RDS_Citizen1",
	"RDS_Citizen_Random",
	"C_man_polo_3_F_asia",
	"ZEPHIK_Female_Civ_12", // Black Garb - F
	"ZEPHIK_Female_Civ_15", // Black Joggers - F
	"RDS_PL_Villager3",
	"RDS_PL_Woodlander4",
	"RDS_PL_Priest",
	"RDS_PL_Policeman"
];

opmerc_civilian_vehicles = [
	"RDS_PL_Van_01_box_f", //     Box Van
	"RDS_PL_Golf4_Civ_01", //     Golf
	"RDS_PL_Hatchback_01_F", //   Hatchback
	"RDS_PL_JAWA353_Civ_01", //   Motorbike
	"RDS_PL_TT650_Civ_01", //     Dirtbike
	"RDS_PL_Zetor6945_BaPL_se",// Tractor
	"RDS_PL_Octavia_Civ_01", //   Volvo
	"RDS_PL_Gaz24_Civ_03",   //   Old
	"RDS_PL_Lada_Civ_01",   //    Old
	"RDS_PL_Lada_Civ_05",   //    Police Car
	"RDS_PL_MMT_Civ_01"     //    Mountain Bike
];

opmerc_pedestrians = [
	"RDS_Citizen1",
	"RDS_Citizen_Random",
	"C_man_polo_3_F_asia",
	"ZEPHIK_Female_Civ_12", // Black Garb - F
	"ZEPHIK_Female_Civ_15", // Black Joggers - F
	"RDS_PL_Villager3",
	"RDS_PL_Woodlander4",
	"RDS_PL_Policeman"
];

opmerc_traffic_men = [
	"RDS_Citizen1",
	"C_man_polo_3_F_asia",
	"ZEPHIK_Female_Civ_15" // Black Joggers - F
];

opmerc_traffic_configurations = [
	// General Population
	[
		[
			"RDS_PL_Golf4_Civ_01", //     Golf
			"RDS_PL_Hatchback_01_F", //   Hatchback
			"RDS_PL_JAWA353_Civ_01", //   Motorbike
			"RDS_PL_Octavia_Civ_01", //   Volvo
			"RDS_PL_Gaz24_Civ_03",   //   Old
			"RDS_PL_Lada_Civ_01",   //    Old
			"RDS_PL_MMT_Civ_01"     //    Mountain Bike	
		],
		opmerc_traffic_men
	],
	// Police unit
	[
		["RDS_PL_Lada_Civ_05"],
		["RDS_PL_Policeman"]
	],
	// Dirtbike Rider
	[
		["RDS_PL_TT650_Civ_01"],
		["RDS_PL_Woodlander4"]
	],
	// Truck Driver
	[
		["RDS_PL_Van_01_box_f"],
		["RDS_Worker4"]
	],
	// Bicyclist
	[
		["RDS_PL_MMT_Civ_01"],
		["ZEPHIK_Female_Civ_15"]
	],
	// Tractor
	[
		["RDS_PL_Zetor6945_BaPL_se"],
		["RDS_PL_Villager3"]
	]
];

_pedradius     = 500;
_trafficradius = 800;

////////////////////////////////

private _nearestroad = getPos ([_front, 1000] call BIS_fnc_nearestRoad);
_pedPop = [] call fnc_civilian_getPedestrianPopulation;
systemChat format ["Civilian Population: %1", _pedPop];
systemChat format ["MAX_PEDESTRIANS: %1", MAX_PEDESTRIANS];
if (_pedPop < MAX_PEDESTRIANS) then {
	private _allowedspawns = MAX_PEDESTRIANS - _pedPop;
	for "_i" from 1 to _allowedspawns do {
		private _group = createGroup civilian;
		_group deleteGroupWhenEmpty true;
		private _pedestrian = _group createUnit [selectRandom opmerc_pedestrians, [_front, _pedradius] call fnc_randPosSafe, [], 0, "NONE"];
		[_group, getPos _pedestrian, _pedradius] call BIS_fnc_taskPatrol;
	};
	systemChat format ["%1 civilians spawned", _allowedspawns];
};

_motoristsPop = [] call fnc_civilian_getMotoristPopulation;
systemChat format ["_motoristsPop Population: %1", _motoristsPop];
systemChat format ["MAX_MOTORISTS: %1", MAX_MOTORISTS];
if (_motoristsPop < MAX_MOTORISTS) then {
	private _allowedspawns = MAX_MOTORISTS - _motoristsPop;
	for "_i" from 1 to _allowedspawns do {
		private _group      	   = createGroup civilian;
		_group deleteGroupWhenEmpty true;
		private _randomComposition = selectRandom opmerc_traffic_configurations;

		private _d 	     = selectRandom (_randomComposition select 1);
		private _c       = selectRandom (_randomComposition select 0);

		private _safepos = [_front, _trafficradius] call fnc_randPosSafe;

		_a = _safepos select 0;
		_b = _safepos select 1;

		private _compvic = _c createVehicle _safepos;
		private _compped = _group createUnit [_d, [_safepos, 150] call fnc_randPosSafe, [], 0, "NONE"];
		_compped moveInDriver _compvic;
		_compped disableAI "FSM";
		_compped disableAI "AUTOCOMBAT";		

		[_group, getPos _compped, _trafficradius] call BIS_fnc_taskPatrol;
		
	};
	systemChat format ["%1 Motorists spawned", _allowedspawns];
};


/*

{
	if (side _x isEqualTo civilian) then {
		{
			deleteWaypoint _x;
		} forEach (waypoints _x);
		[_x, _front, _bf_distance] call BIS_fnc_taskPatrol;
		systemChat format ["Civ Manager: %1 updated | Side Check: %2", _x, side _x];		
	};
} forEach allGroups findIf {({ alive _x } count units _x > 0 ) && ((side _x) isEqualTo civilian) && !([_x] call fnc_shouldIgnoreGroupByVehicleIndication)};

*/
