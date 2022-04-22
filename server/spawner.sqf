// Global ->
// [...] call spawner;
_trigger               = _this select 0; // Trigger    
private _location_meta = _trigger getVariable ["location_meta", false];

private _poiName 	   = _location_meta select 0; // POI Name              - String - name of the POI to show
private _pos           = _location_meta select 1; // POI Position          - Array  - [x,y,z] 
private _locationType  = _location_meta select 2; // POI Type              - String - type of the POI
private _locationUID   = _location_meta select 3; // POI UID               - String - unique ID of the POI
private _locationMarker= _location_meta select 4; // POI Marker            - String - marker of the POI

// Radius's
private _infantryRadius= _location_meta select 5; // Infantry Spawn Radius 
private _vehicleRadius = _location_meta select 6; // Vehicle Spawn Radius
private _airRadius     = _location_meta select 7; // Air Spawn Radius
private _armorRadius   = _location_meta select 8; // Armor Spawn Radius

// Get Amounts to spawn
private _infantryAmount= selectRandom (_location_meta select 9); // Infantry Amount  
private _vehicleAmount = selectRandom (_location_meta select 10); // Vehicle Amount
private _airAmount     = selectRandom (_location_meta select 11); // Air Amount
private _armorAmount   = selectRandom (_location_meta select 12); // Armor Amount


private _marker = ["marker_", _locationUID] call fnc_nameToUID; // Get Marker name


// Set Sector active
_sectors = missionNamespace getVariable ["ACTIVE_SECTORS", []];
missionNamespace setVariable ["ACTIVE_SECTORS", _sectors + [_locationUID], true];

if (DEBUG) then {
	systemChat format ["%1 - %2 is proxed - Active Sectors: ", _poiName, _locationType, count ACTIVE_SECTORS];
};

// All units spawned at point of interest.
_units 			= [];

for "_i" from 1 to _airAmount do {
	private _randomUnit = selectRandom [
		"min_rf_ka_52",
		"RHS_T50_vvs_blueonblue",
		"rhs_mig29s_vvsc",
		"rhs_mig29sm_vvsc",
		"RHS_Su25SM_vvsc",
		"RHS_Su25SM_CAS_vvsc",
		"RHS_Su25SM_Cluster_vvsc",
		"RHS_Su25SM_KH29_vvsc",
		"CUP_O_Ka50_DL_RU",
		"RHS_Ka52_vvsc",
		"min_rf_ka_52",
		"CUP_O_Mi24_P_Dynamic_RU",
		"CUP_O_Mi24_V_Dynamic_RU"
	];

	private _randomPos = [[[getPos _trigger, _airRadius]], []] call BIS_fnc_randomPos;

	private _safepos   = [getPos _trigger, 1, _airRadius, 5, 0, 15, 0, [], []] call BIS_fnc_findSafePos;

	private _veh       = createVehicle [_randomUnit, [[0, 0, 500], _randomPos] call BIS_fnc_vectorAdd, [], 500, "FLY"];

	// Ensure level-ground / sane sea-level placement
	//_veh setVectorUp surfaceNormal (getposATL _veh);

	// Unlimited Ammo for all vehicles.
	_veh addEventHandler ["Fired", {(_this select 0) setVehicleAmmo 1}];

	private _crew = createVehicleCrew _veh;	

	_crew deleteGroupWhenEmpty true;
	_crew setBehaviour "CBT";	// CBT = Combat Behaviour
	_crew allowFleeing 0; //
	_crew setSpeedMode "FULL";

	{
		//_x addGoggles "G_CBRN_M50_Hood";
		// Add armor crews to _units[]
		_units pushBack _x;
	} forEach units _crew;

	// Entire crew (armor element) group patrol.
	[group _veh, getPos _trigger, _armorRadius] call bis_fnc_taskPatrol;
	
	// LAMBS_danger.fsm - dynamicReinforce
	_crew setVariable ["lambs_danger_enableGroupReinforce", true, true];

	_crew enableAttack true;

};

for "_i" from 1 to _vehicleAmount do {
	private _randomUnit = selectRandom [
		"rhs_tigr_sts_vmf",
		"min_rf_gaz_2330_HMG",
		"CUP_O_UAZ_METIS_RU",
		"CUP_O_UAZ_AGS30_RU",
		"CUP_O_UAZ_SPG9_RU",
		"CUP_O_MTLB_pk_Green_RU",
		"CUP_O_UAZ_AA_RU",
		"CUP_O_GAZ_Vodnik_KPVT_RU",
		"CUP_O_GAZ_Vodnik_BPPU_RU",
		"CUP_O_GAZ_Vodnik_AGS_RU",
		"CUP_O_GAZ_Vodnik_PK_RU"
	];

	private _randomPos = [[[getPos _trigger, _vehicleRadius]], []] call BIS_fnc_randomPos;

	private _safepos   = [getPos _trigger, 1, _vehicleRadius, 5, 0, 15, 0, [], []] call BIS_fnc_findSafePos;

	private _veh       = createVehicle [_randomUnit, _randomPos, [], 150, "NONE"];

	// Ensure level-ground / sane sea-level placement
	_veh setVectorUp surfaceNormal (getposATL _veh);

	// Unlimited Ammo for all vehicles.
	_veh addEventHandler ["Fired", {(_this select 0) setVehicleAmmo 1}];

	private _crew = createVehicleCrew _veh;	

	_crew deleteGroupWhenEmpty true;
	_crew setBehaviour "CBT";	// CBT = Combat Behaviour
	_crew allowFleeing 0; //
	_crew setSpeedMode "FULL";

	{
		//_x addGoggles "G_CBRN_M50_Hood";
		// Add armor crews to _units[]
		_units pushBack _x;
	} forEach units _crew;

	// Entire crew (armor element) group patrol.
	//[group _veh, getPos _trigger, _armorRadius] call bis_fnc_taskPatrol;
	
	// LAMBS_danger.fsm - dynamicReinforce
	_crew setVariable ["lambs_danger_enableGroupReinforce", true, true];

	_crew enableAttack true;

};

for "_i" from 1 to _armorAmount do {
	private _randomUnit = selectRandom [
		"rhs_Ural_Zu23_VDV_01",
		"rhs_btr80_vdv",
		"rhs_btr80a_vv",
		"rhs_t72be_tv",
		"rhs_t80um",
		"rhs_t90sab_tv",
		"rhs_zsu234_aa",
		"rhsgref_BRDM2_ATGM_vmf",
		"rhs_sprut_vdv",
		"rhs_bmp2k_vmf",
		"rhs_tigr_sts_vmf",
		"min_rf_t_15",
		"rhs_t14_tv",
		"rhs_t80a",
		"CUP_O_BRDM2_RUS",
		"CUP_O_BMP3_RU",
		"CUP_O_2S6M_RU",
		"CUP_O_2S6_RU",
		"min_rf_sa_22"
	];

	private _randomPos = [[[getPos _trigger, _armorRadius]], []] call BIS_fnc_randomPos;

	private _safepos   = [getPos _trigger, 1, _armorRadius, 5, 0, 15, 0, [], []] call BIS_fnc_findSafePos;

	private _veh       = createVehicle [_randomUnit, _randomPos, [], 150, "NONE"];

	// Ensure level-ground / sane sea-level placement
	_veh setVectorUp surfaceNormal (getposATL _veh);

	// Unlimited Ammo for all vehicles.
	_veh addEventHandler ["Fired", {(_this select 0) setVehicleAmmo 1}];

	private _crew = createVehicleCrew _veh;	

	_crew deleteGroupWhenEmpty true;
	_crew setBehaviour "CBT";	// CBT = Combat Behaviour
	_crew allowFleeing 0; //
	_crew setSpeedMode "FULL";

	{
		//_x addGoggles "G_CBRN_M50_Hood";
		// Add armor crews to _units[]
		_units pushBack _x;
	} forEach units _crew;

	// Entire crew (armor element) group patrol.
	//[group _veh, getPos _trigger, _armorRadius] call bis_fnc_taskPatrol;
	
	// LAMBS_danger.fsm - dynamicReinforce
	_crew setVariable ["lambs_danger_enableGroupReinforce", true, true];

	_crew enableAttack true;

};

OPMERC_infantry_groups = [
	["weapons_team", [
		"rhs_vdv_sergeant",
		"rhs_vdv_machinegunner",
		"rhs_vdv_machinegunner",
		"rhs_vdv_machinegunner_assistant",
		"rhs_vdv_marksman",
		"rhs_vdv_at",
		"rhs_vdv_LAT",
		"rhs_vdv_aa"
	]],
	["fire_team", [
		"rhs_vdv_sergeant",
		"rhs_vdv_rifleman",
		"rhs_vdv_rifleman",
		"rhs_vdv_rifleman",
		"rhs_vdv_rifleman",			
		"rhs_vdv_RShG2",
		"rhs_vdv_RShG2",
		"rhs_vdv_grenadier_rpg",
		"rhs_vdv_grenadier_rpg",
		"rhs_vdv_recon_rifleman_l",
		"rhs_vdv_medic",
		"rhs_vdv_medic",
		"rhs_vdv_arifleman",
		"rhs_vdv_arifleman",
		"rhs_vdv_machinegunner_assistant"
	]],
	["medical_team", [
		"rhs_vdv_sergeant",
		"rhs_vdv_medic",
		"rhs_vdv_medic",
		"rhs_vdv_medic"
	]],
	["recon_team", [
		"rhs_vdv_recon_officer",
		"rhs_vdv_recon_efreitor",
		"rhs_vdv_recon_arifleman_scout",
		"rhs_vdv_recon_rifleman_l",
		"rhs_vdv_recon_rifleman_scout_akm",
		"rhs_vdv_recon_arifleman_rpk_scout"
	]],
	["spetznaz", [
		"min_rf_spetsnaz_TL",
		"min_rf_spetsnaz_M",
		"min_rf_spetsnaz_M",
		"min_rf_spetsnaz",
		"min_rf_spetsnaz",
		"min_rf_spetsnaz",
		"min_rf_spetsnaz",
		"min_rf_spetsnaz_O",
		"min_rf_spetsnaz_O",
		"min_rf_spetsnaz_O",
		"min_rf_spetsnaz_O",
		"min_rf_spetsnaz_GL",
		"min_rf_spetsnaz_GL",
		"min_rf_spetsnaz_AR",
		"min_rf_spetsnaz_AR"
	]]
];

for "_i" from 1 to _infantryAmount do {

	private _group        = createGroup east;

	private _generalpos   = [[[getPos _trigger, _infantryRadius]], []] call BIS_fnc_randomPos;

	private _randomGroup  = selectRandom OPMERC_infantry_groups;

	private _opmerc_group_name  = _randomGroup select 0;
	private _opmerc_group_units = _randomGroup select 1;

	{
		private _safepos   = [_generalpos, 1, 20, 2, 0, 25, 0, [], []] call BIS_fnc_findSafePos;

		private _thisUnit = _group createUnit [_x, _safepos, [], 100, "NONE"];

		// Ensure level-ground / sane sea-level placement
		_thisUnit setVectorUp surfaceNormal (getposATL _thisUnit);	

		_thisUnit allowFleeing 0; //	

		// Add CBRN mask
		//_thisUnit addGoggles "G_CBRN_M50_Hood";

		// Rand aim accuracy
		_thisUnit setSkill ["aimingAccuracy", selectRandom [0.4, 0.5, 0.6, 0.7, 0.8]];

		// Add infantry to _units[]
		_units pushBack _thisUnit;

		//systemChat format ["%1: %2", _thisUnit, _opmerc_group_name];
	} forEach _opmerc_group_units;

	_group deleteGroupWhenEmpty true;
	_group setBehaviour "CBT";	// CBT = Combat Behaviour
	_group allowFleeing 0; //
	_group setSpeedMode "FULL";
	_group enableAttack true;

	// LAMBS_danger.fsm - dynamicReinforce
	//_group setVariable ["lambs_danger_enableGroupReinforce", true, true];	


	// Patrol the radius
	[_group, getPos _trigger, _infantryRadius] call BIS_fnc_taskPatrol;

	//systemChat format ["Spawned Group: %1", _opmerc_group_name];	

};

systemChat format ["Spawned %1 total units", count _units];

/////////////////// Sector Loop -> ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
while { ({ alive _x } count _units > 0) } do {
	sleep 1;
};
// End of Sector Loop

// Set Sector inactive
_sectors = missionNamespace getVariable ["ACTIVE_SECTORS", []];
missionNamespace setVariable ["ACTIVE_SECTORS", _sectors - [_locationUID], true];

// Add to captured sectors
_sectors = missionNamespace getVariable ["CAPTURED_SECTORS", []];
missionNamespace setVariable ["CAPTURED_SECTORS", _sectors + [_locationUID], true];

savedCaptures = profileNamespace getVariable ["SAVED_CAPTURED_SECTORS", []];

// Saves persistent array of names of sectors we've captured.
if !(_poiName in savedCaptures) then {
	savedCaptures = savedCaptures + [_poiName];
	profileNamespace setVariable ["SAVED_CAPTURED_SECTORS", savedCaptures];
};

// delete the trigger since we no longer need it/
deleteVehicle _trigger;

_marker setMarkerColor "ColorBlue";

private _addedFunds = 0;
switch (_locationType) do {
	case "NameCityCapital": {
		_addedFunds = 100000000; // 100m
	};
	case "NameCity": {
		_addedFunds = 10000000; // 10m
	};
	case "NameVillage": {
		_addedFunds = 1000000; // 1m
	};
	case "NameLocal": {
		_addedFunds = 1000000; // 1m
	};
	default {
		_addedFunds = 1000000; // 1m
	};
};
private _newFunding = CURRENT_FUNDING_BALANCE + _addedFunds;
missionNamespace setVariable ["CURRENT_FUNDING_BALANCE", _newFunding, true]; 
profileNamespace setVariable ["SAVED_FUNDING_BALANCE", _newFunding]; 

// Notify of the capture
private _newFundingLine = format["New Funding: %1", [_addedFunds, true] call fnc_standardNumericalNotationString];
private _totalFundingLine = format["Total Funding: %1", [_newFunding, true] call fnc_standardNumericalNotationString];
[format ["We have captured %1!\n%2\n%3", _poiName, _newFundingLine, _totalFundingLine]] call void_globalHint;






