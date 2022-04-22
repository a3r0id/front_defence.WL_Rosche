// https://community.bistudio.com/wiki/Initialization_Order

fnc_getMapCenter    = {
    getArray (configfile >> "CfgWorlds" >> worldName >> "centerPosition")
};

fnc_getMapRadius    = {
    private _map_size = [(getArray (configfile >> "CfgWorlds" >> worldName >> "centerPosition")), 2] call BIS_fnc_vectorMultiply;
	if ((_map_size select 0) < (_map_size select 1)) then {(_map_size select 0)} else {(_map_size select 1)}
};

fnc_nameToUID       = {
    params["_prefix", "_name"];
    toLower (_prefix + _name splitString "" joinString "_")
};

fnc_getAllLocations = {
    // Returns -> [["Name", [x, y, z], "type"], ...]   
    _placesCfg = configFile >> "CfgWorlds" >> worldName >> "Names";
    _placesToKeep = ["NameCityCapital","NameCity","NameVillage"];
    _places = [];
    for "_i" from 0 to (count _placesCfg)-1 do
    {
        _place    = _placesCfg select _i;
        _name     = getText(_place >> "name");
        _position = getArray (_place >> "position");
        _type     = getText(_place >> "type");
        _uid      = ["fd_locations_", _name] call fnc_nameToUID;
        _places set [_i, [_name, _position, _type, _uid, false, []]];
                        //name, position, type, uid, isActive, args
    };
    _places
};

fnc_getFundingBalance = {
	// Returns balance or -1 if error
	[missionNamespace, "CURRENT_FUNDING_BALANCE", -1] call BIS_fnc_getServerVariable
};

fnc_subtractFunding = {
	// Returns true if we had enough to remove else, false if error
	params["_amount"];
	private _balance = [] call fnc_getFundingBalance;
	private _cleared = false;
	if (_balance >= _amount) then {
		newAmount_ =  _balance - _amount;
		// Set new funding on server
		[missionNamespace, "CURRENT_FUNDING_BALANCE", newAmount_] call BIS_fnc_setServerVariable;
		[profileNamespace, "SAVED_FUNDING_BALANCE", newAmount_] call BIS_fnc_setServerVariable;
		_cleared = true;
	};
	_cleared
};

fnc_addFunding = {
	// Returns true if we had enough to remove else, false if error
	params["_amount"];
	private _balance = [] call fnc_getFundingBalance;
	private _cleared = false;
	_newamount = _balance + _amount;
	[missionNamespace, "CURRENT_FUNDING_BALANCE", _newamount] call BIS_fnc_setServerVariable;
	[profileNamespace, "SAVED_FUNDING_BALANCE", _newamount] call BIS_fnc_setServerVariable;
	_cleared = true;
	_cleared
};

fnc_inFrontOf = {
	// Gets position of distance in front of object/unit/vehicle
	params["_unitOrObject", "_distance"];
	_pos = getPosATL _unitOrObject;
	_azimuth = getDir _unitOrObject;
	_px = (_pos select 0) + (_distance * (sin _azimuth));
	_py = (_pos select 1) + (_distance * (cos _azimuth));
	[_px, _py, (_pos select 2)]
};

fnc_standardNumericalNotationString = {
	params["_number", "_isMoney"];
	private _string = (([_number] call BIS_fnc_numberText) splitString " ") joinString ",";
	if (_isMoney) then {
		_string = format ["%1%2 %3", FUNDING_SYMBOL, _string, FUNDING_TYPE];
	};
	_string
};

fnc_randPos = {
    params ["_center", "_radius"];
    // random pos 
    private _rp        = [[[_center, _radius]], []] call BIS_fnc_randomPos;
    // safe position
	private _sp        = [_rp, 3, 20, 3, 0, 20, 0] call BIS_fnc_findSafePos;
    
    _sp
};

fnc_getFopLocation = {
	/// returns location or false
	private _fop = missionNamespace getVariable ["FOP_LOCATION", false];
	systemChat format ["GOT FOP LOCATION: %1", _fop];
	if ((typeName _fop) != "ARRAY") then {
		_fop = false;
	};
	_fop
};

fnc_setFopLocation = {
	params ["_location"];
	private _location_safe = [_location select 0, _location select 1, _location select 2];
	[missionNamespace, "FOP_LOCATION", _location_safe] call BIS_fnc_setServerVariable;
	[profileNameSpace, "SAVED_FOP_LOCATION", _location_safe] call BIS_fnc_setServerVariable;
	systemChat format ["SET FOP LOCATION: %1", _location_safe];
};

fnc_getFobLocation = {
	/// returns location or false
	private _fob = missionNamespace getVariable ["FOB_LOCATION", false];
	systemChat format ["GOT FOB LOCATION: %1", typeName _fob];
		if ((typeName _fob) != "ARRAY") then {
		_fob = false;
	};
	_fob
};

fnc_setFobLocation = {
	params ["_location"];
	private _location_safe = [_location select 0, _location select 1, _location select 2];
	[missionNamespace, "FOB_LOCATION", _location_safe] call BIS_fnc_setServerVariable;
	[profileNameSpace, "SAVED_FOB_LOCATION", _location_safe] call BIS_fnc_setServerVariable;
	systemChat format ["SET FOB LOCATION: %1", _location_safe];
};

fnc_getGroupVehicles = {
	_vehs = [];
	{
		_veh = vehicle _x;
		_inArray = _veh in _vehs;
		if (not _inArray and {_veh != _x}) then
		{
			_vehs set [count _vehs, _veh];
		};
	} forEach units _group;
	_vehs
};

// A useful redundancy check to identify if a vehicle is in a group that we should ignore, i/e: drones show up as civ (it seems) so we want to ignore them in civi manager.
fnc_shouldIgnoreGroupByVehicleIndication = {
	params["_group"];
	private _should_ignore = false;
	private _ignore_vehicles = [
		"ITC_Land_B_UAV_AR2i"
	];
	private _group_vehicles = [_group] call fnc_getGroupVehicles;
	{
		if (_x in _ignore_vehicles) then {
			_should_ignore = true;
		};
	} forEach _group_vehicles;
	_should_ignore
};

// CONFIG, FOR NOW...

// Set Global Variables
FUNDING_SYMBOL           = "$";
FUNDING_TYPE             = "USD";
COMMAND_TERMINAL_OBJECT  = "";


FD_supply_crates = [
	[
		"general_resupply",
		"Box_NATO_Equip_F",
		[
            ["launch_MRAWS_sand_rail_F", 3],
            ["rhs_weap_M590_8RD", 2],
            ["rhs_weap_M320", 2]
		],
		[
            ["rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red", 100],
            ["rhs_mag_30Rnd_556x45_Mk262_PMAG_Tan", 100],
            ["rhsusf_100Rnd_762x51_m62_tracer", 30],
            ["rhsusf_100Rnd_762x51_m61_ap", 30],
            ["rhsusf_100Rnd_762x51_m80a1epr", 30],
            ["rhs_mag_m67", 10],
            ["MiniGrenade", 10],
            ["SLAMDirectionalMine_Wire_Mag", 1],
            ["ACE_FlareTripMine_Mag", 1],
            ["rhsusf_m112x4_mag", 5],
            ["rhs_mag_100Rnd_556x45_M855_cmag_mixed", 10],
            ["6Rnd_12Gauge_Pellets", 10],
            ["ACE_6Rnd_12Gauge_Pellets_No4_Bird", 10],
            ["rhs_mag_20Rnd_SCAR_762x51_m61_ap", 50],
            ["rhs_mag_20Rnd_SCAR_762x51_m62_tracer", 50],
            ["rhs_mag_maaws_HEAT", 10],
            ["rhs_mag_maaws_HE", 10],
            ["rhsgref_1Rnd_00Buck", 20],
            ["rhsgref_1Rnd_Slug", 10],
            ["ACE_40mm_Flare_white", 100],
            ["rhs_mag_m576", 10],
            ["rhs_mag_m4009", 10],
            ["ACE_HuntIR_M203", 10],
            ["rhs_mag_M397_HET", 50],
            ["rhs_mag_M433_HEDP", 50],
            ["rhs_mag_M441_HE", 50],
            ["ACE_40mm_Flare_ir", 10],
            ["1Rnd_SmokeGreen_Grenade_shell", 10]      
		],
		[
			// Crate Items
            ["ACE_elasticBandage", 50],
            ["ACE_packingBandage", 50],
            ["ACE_fieldDressing", 20],
            ["ACE_bloodIV", 5],
            ["ACE_bloodIV_250", 10],
            ["ACE_bloodIV_500", 10],
            ["ACE_EntrenchingTool", 5],
            ["ACE_epinephrine", 10],
            ["itc_land_tablet_fdc", 1],
            ["ACE_HuntIR_monitor", 1],
            ["ACE_IR_Strobe_Item", 5],
            ["ACE_morphine", 10],
            ["ACE_plasmaIV_250", 5],
            ["ACE_salineIV_250", 10],
            ["ACE_splint", 10],
            ["ACE_tourniquet", 10],
            ["ACE_WaterBottle", 10],
            ["ACE_SpottingScope", 1],
            ["ACE_Sandbag_empty", 1],
            ["ACE_SpareBarrel", 2],
            ["rhs_mag_an_m8hc", 20]                 
		]
	],
	[
		"empty_resupply",
		"Box_NATO_Equip_F",
		[],
		[],
		[]
	],
	[
		"medical_resupply",
		"ACE_medicalSupplyCrate_advanced",
		[],
		[],
		[
            ["kat_IV_16", 50],
            ["ACE_adenosine", 5],
            ["kat_X_AED", 1],
            ["ACE_fieldDressing", 20],
            ["ACE_elasticBandage", 50],
            ["ACE_packingBandage", 50],
            ["ACE_quikclot", 10],
            ["ACE_bloodIV", 20],
            ["ACE_bloodIV_250", 20],
            ["ACE_bloodIV_500", 20],
            ["ACE_epinephrine", 10],
            ["kat_etomidate", 5],
            ["kat_IO_FAST", 5],
            ["kat_flumazenil", 1],
            ["kat_lidocaine", 10],
            ["kat_lorazepam", 1],
            ["ACE_morphine", 10],
            ["kat_naloxone", 5],
            ["kat_nitroglycerin", 5],
            ["kat_norepinephrine", 5],
            ["kat_phenylephrine", 5],
            ["ACE_personalAidKit", 1],
            ["ACE_plasmaIV_500", 5],
            ["ACE_salineIV_500", 10],
            ["ACE_salineIV_250", 15],
            ["ACE_salineIV", 10],
            ["kat_scalpel", 1],
            ["ACE_splint", 10],
            ["ACE_tourniquet", 15],
            ["kat_TXA", 10]            
        ]
	],
	[
		"at_resupply",
		"Box_NATO_Equip_F",
		[
			// Crate Weapons
            ["rhs_weap_fgm148", 2], // Javelin
            ["rhs_weap_fim92", 2], // stinger
            ["rhs_weap_M136", 10] // AT4 (HEAT)
		],
		[
			// Crate Magazines
            ["rhs_fgm148_magazine_AT", 10],
            //["Titan_AA", 5],
            ["rhs_fim92_mag", 5]       
		],
		[
			// Crate Items
		]
	]
];

FD_static_weapons = [
	"RHS_TOW_TriPod_USMC_D",
	"RHS_Stinger_AA_pod_USMC_D",
	"RHS_MK19_TriPod_USMC_D",
	"B_T_Mortar_01_F",
	"RHS_M2StaticMG_D",
	"RHS_M2StaticMG_MiniTripod_D"
];
