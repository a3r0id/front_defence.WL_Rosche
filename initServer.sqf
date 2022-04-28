RESTART_MISSION_ON_START = false;

call compileFinal preprocessFile "config\opfor_vehicles.sqf";
call compileFinal preprocessFile "config\opfor_infantry.sqf";
systemChat "[DEBUG] OPFOR Configuration loaded";

// Fob/fop type
CURRENT_FOB_TYPE = "fob1.sqf";
CURRENT_FOP_TYPE = "fop1.sqf";
publicVariable "CURRENT_FOB_TYPE";
publicVariable "CURRENT_FOP_TYPE";

GAMETYPES = [
    "pve_as_bf",
    "pve_as_of",
    "pvp"
];

// Server Utility Functions
void_globalChat      = {
	params["_message"];
	_message remoteExec ["systemChat", 0];		
};

void_globalHint      = {
	params["_message"];
	_message remoteExec ["hint", 0];		
};

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

fnc_sector_getActiveSectors = {
    // Returns false if failed
    missionNamespace getVariable ["ACTIVE_SECTORS", false]
};

fnc_getLocationByUID = {
    _location = [];
    params["_uid"];
    {
        
        private _thisUid = _x select 4;
        systemChat format ["Location UID: %1", _thisUid];
        if (_thisUid isEqualTo _uid) then {
            _location = _x;
        };
    } forEach (missionNamespace getVariable ["LOCATIONS", []]);
    _location
};

fnc_sector_isSectorActive = {
    params["_sector_id"];
    private _location = [_sector_id] call fnc_getLocationByUID;
    if (isNil "_location") then {
        hint format["fnc_sector_isSectorActive('%1') -> Error: Sector not found", _sector_id];
    };
    if ((_location select 3) in ACTIVE_SECTORS) then {true} else {false}
};

void_sector_setSectorActive = {
    params["_sector_id", "_isActive"];
    private _location = [_sector_id] call fnc_getLocationByUID;
    if (isNil "_location" || count _location == 0) exitWith {
            systemChat format["fnc_sector_setSectorActive('%1', %2) -> Error: Sector not found", _sector_id, _isActive];
    };
    _newActiveSectors = [] call fnc_sector_getActiveSectors;
    if (_isActive) then {
        _newActiveSectors pushBack (_location select 4);
        
    } else {
        _newActiveSectors = _newActiveSectors - [_location select 4];
    };
    missionNamespace setVariable ["ACTIVE_SECTORS", _newActiveSectors];
};

fnc_getServerPop    = {
    _bf = 0;
    _of = 0;
    _re = 0;
    _ci = 0;
    _pl = 0; // Seperate
    {
        switch (side _x) do {
            case west: {
                _bf = _bf + 1;
            };
            case east: {
                _of = _of + 1;
            };
            case resistance: {
                _re = _re + 1;
            };
            case civilian: {
                _ci = _ci + 1;
            };
            default {};
        };        
    } forEach allUnits;
    [_bf, _of, _re, _ci, count allPlayers] call fnc_getServerPop
};

fnc_triggerToLocationId = {
    params["_trigger"];
    //systemChat format["fnc_triggerToLocationId('%1') -> %2", _trigger, _trigger getVariable "LOCATION_ID"];
    private _uid = _trigger getVariable['LOCATION_ID', false];
    _uid
};

fnc_civilian_getMotoristPopulation = {
    _population = 0;
    {
        if ((side _x == civilian) && !(isNull objectParent _x)) then {
            _population = _population + 1;
        };
    } forEach allUnits;
    _population
};

fnc_civilian_getPedestrianPopulation = {
    _population = 0;
    {
        if ((side _x == civilian) && (isNull objectParent _x)) then {
            _population = _population + 1;
        };
    } forEach allUnits;
    _population
};

fnc_randPosSafe = {
    params ["_center", "_radius"];
    private _rp        = [[[_center, _radius]], []] call BIS_fnc_randomPos;
	private _sp        = [_rp, 3, 150, 5, 0, 20, 0] call BIS_fnc_findSafePos;
    _sp
};

fnc_addToPurchasedVehicles = {
    // Adds a vehicle to the persistant list of purchased vehicles. Does nothing for the current spawned vehicle.
    params["_vehicle", "_init"];
    private _v = [profileNamespace, "SAVED_PURCHASED_VEHICLES", []] call BIS_fnc_getServerVariable;
    _v pushBack (typeOf _vehicle);
    [profileNamespace, "SAVED_PURCHASED_VEHICLES", _v] call BIS_fnc_setServerVariable;

    // Set a default init script for the vehicle type.
    private _n = "DEFAULT_INIT_" + (typeOf _vehicle);

    private _v = [profileNamespace, _n, _init] call BIS_fnc_getServerVariable;
    systemChat format["fnc_addToPurchasedVehicles('%1', %2) -> %3", _vehicle, _init, _v];

};

fnc_groupHasVehicle = {
    params["_group"];
    {
        if (count typeOf(assignedVehicle player) > 0) exitWith {true};
    } forEach units _group;
    false
};

fnc_groupMedianPosition = {
    params["_group"];
    private _px = []; private _py = []; private _pz = [];
    {
        private _pos = getPos _x;
        _px pushBack (_pos select 0);
        _py pushBack (_pos select 1);
        _pz pushBack (_pos select 2);
    } forEach units _group;

    [
        round (_px call BIS_fnc_arithmeticMean),
        round (_py call BIS_fnc_arithmeticMean),
        round (_pz call BIS_fnc_arithmeticMean)
    ]
};

fnc_server_setFobLocation = {
    params["_location"];
    profileNameSpace setVariable ["SAVED_FOB_LOCATION", _location];
    missionNameSpace setVariable ["FOB_LOCATION", _location, true];
};

fnc_server_setFopLocation = {
    params["_location"];
    profileNameSpace setVariable ["SAVED_FOP_LOCATION", _location];
    missionNameSpace setVariable ["FOP_LOCATION", _location, true];
};

fnc_server_setVar = {
    params["_var", "_value"];
    profileNameSpace setVariable [_var, _value];
    missionNameSpace setVariable [_var, _value, true];
};

// End Server Utility Functions

// Set Server Variables
missionNamespace setVariable ["RESTART_MISSION",      RESTART_MISSION_ON_START, true];
missionNamespace setVariable ["FUNDING_START_BALANCE",      100000000, true];
missionNamespace setVariable ["DEBUG",      false, true];
missionNamespace setVariable ["GAME_TYPE",  0, true];
missionNamespace setVariable ["MAX_ACTIVE_SECTORS",  2, true];
missionNamespace setVariable ["PLAYER_SIDE", west, true];// west, east, independent, civilian, resistance, "pvp" = pvp any (GAME_TYPE[2])
missionNamespace setVariable ["MAX_PEDESTRIANS",  8, true];
missionNamespace setVariable ["MAX_MOTORISTS",  8, true];
missionNamespace setVariable ['MAP_CENTER', [] call fnc_getMapCenter,    true];
missionNamespace setVariable ['MAP_RADIUS', [] call fnc_getMapRadius,    true];
missionNamespace setVariable ['LOCATIONS',  [] call fnc_getAllLocations, true];
missionNamespace setVariable ["IS_FRONT_DEFENCE", true];
missionNamespace setVariable ["ACTIVE_SECTORS", [], true];

savedCaptures          = profileNamespace getVariable ["SAVED_CAPTURED_SECTORS", []];

savedPurchasedVehicles = profileNamespace getVariable ["SAVED_PURCHASED_VEHICLES", []];

savedFobLocation       = profileNamespace getVariable ["SAVED_FOB_LOCATION", false];

savedFopLocation       = profileNamespace getVariable ["SAVED_FOP_LOCATION", false];

savedFunding           = profileNamespace getVariable ["SAVED_FUNDING_BALANCE", FUNDING_START_BALANCE];


// Clears all save data if RESTART_MISSION is true
if (RESTART_MISSION) then {
    // Clear all captured sectors
    missionNamespace setVariable ["CAPTURED_SECTORS", [], true];
    profileNamespace setVariable ["SAVED_CAPTURED_SECTORS", []];

    // Set initial funding balance
    missionNamespace setVariable ["CURRENT_FUNDING_BALANCE",   FUNDING_START_BALANCE, true]; 
    profileNamespace setVariable ["SAVED_FUNDING_BALANCE",   FUNDING_START_BALANCE];   

    // Set purchased vehicles empty
    missionNamespace setVariable ["PURCHASED_VEHICLES", [], true];
    profileNamespace setVariable ["SAVED_PURCHASED_VEHICLES", []];

    // Set Fob/Fop locations
    missionNamespace setVariable ["FOB_LOCATION", false, true];
    missionNamespace setVariable ["FOP_LOCATION", false, true];
    profileNamespace setVariable ["SAVED_FOB_LOCATION", false];
    profileNamespace setVariable ["SAVED_FOP_LOCATION", false];

    // Clear Purchased Vehicles
    profileNamespace setVariable ["SAVED_PURCHASED_VEHICLES", []];

    systemChat "[SERVER] All save data cleared -> Change 'RESTART_MISSION' TO false in initServer.sqf to save progress!";

} else {
    // Saved captures
    missionNamespace setVariable ["CAPTURED_SECTORS", savedCaptures, true];

    // Saved funding balance
    missionNamespace setVariable ["CURRENT_FUNDING_BALANCE", savedFunding, true];

    // Saved purchased vehicles
    missionNamespace setVariable ["PURCHASED_VEHICLES", savedPurchasedVehicles, true];   

    // Set Fob/Fop locations
    missionNamespace setVariable ["FOB_LOCATION", savedFobLocation, true];
    missionNamespace setVariable ["FOP_LOCATION", savedFopLocation, true];

    // Build FOB
    if !(savedFobLocation isEqualTo false) then {
        [savedFobLocation] execVM "server\compositions\fobs\fob1.sqf";
        systemChat format["FOB BUILT - Fob Location: %1", savedFobLocation];
    };

    // Build FOP
    if !(savedFopLocation isEqualTo false) then {
        [savedFopLocation] execVM "server\compositions\fops\fop1.sqf";
        systemChat format["FOP BUILT - Fop Location: %1", savedFopLocation];
    };

    systemChat "[SERVER] Loaded last save";
};

missionNamespace setVariable ["BLUFOR_MEAN_POS", false, true];
missionNamespace setVariable ["OPFOR_MEAN_POS", false, true];
missionNamespace setVariable ["LOCATION_TYPES", ["NameLocal", "NameVillage", "NameCity", "NameCityCapital"], true];

systemChat format["[DEBUG] Server Variables Set"];

// Establish Sectors
{
    private _name   = _x select 0;
    private _pos    = _x select 1;
    private _type   = _x select 2;
    // If location type not in desired location types array then continue unless debugging
    if (!(_type in LOCATION_TYPES) && !(DEBUG)) then {continue};
    private _uid    = _x select 3;
    private _marker = ["marker_", _uid] call fnc_nameToUID;

    private _radiusInfantry      = 0;
    private _radiusVehicles      = 0;
    private _radiusAir           = 0;
    private _radiusArmor         = 0;

    private _infantryCountRange  = 0;
    private _vehiclesCountRange  = 0;
    private _airCountRange       = 0;
    private _armorCountRange     = 0;

    //private _markerColor         = "ColorWhite";
    private _markerType          = "mil_dot";
    
    
    switch (_type) do {
        case "NameLocal": {
            _radiusInfantry      = 250;
            _radiusVehicles      = 500;
            _radiusAir           = 800;
            _radiusArmor         = 600;

            _infantryCountRange  = [8, 10];
            _vehiclesCountRange  = [3, 6];
            _airCountRange       = [1, 2];
            _armorCountRange     = [1, 3];

            //_markerColor         = "ColorYellow";  
            _markerType          = "o_support";          
        };        
        case "NameVillage": {
            _radiusInfantry      = 250;
            _radiusVehicles      = 500;
            _radiusAir           = 800;
            _radiusArmor         = 600;

            _infantryCountRange  = [6, 12];
            _vehiclesCountRange  = [2, 8];
            _airCountRange       = [0, 3];
            _armorCountRange     = [1, 3];

            //_markerColor         = "ColorGreen"; 
            _markerType          = "o_unknown";           
        };
        case "NameCity": {
            _radiusInfantry      = 500;
            _radiusVehicles      = 1000;
            _radiusAir           = 1500;
            _radiusArmor         = 1000;

            _infantryCountRange  = [10, 16];
            _vehiclesCountRange  = [6, 10];
            _airCountRange       = [2, 4];
            _armorCountRange     = [3, 7];

            //_markerColor         = "ColorBlue";
            _markerType          = "o_unknown";
        };
        case "NameCityCapital": {
            _radiusInfantry      = 800;
            _radiusVehicles      = 1000;
            _radiusAir           = 2000;
            _radiusArmor         = 1200;

            _infantryCountRange  = [12, 20];
            _vehiclesCountRange  = [10, 20];
            _airCountRange       = [3, 6];
            _armorCountRange     = [8, 12];

            //_markerColor         = "ColorRed";
            _markerType          = "o_unknown";
        };
        default { };
    };

        // Get mean of radius'
    private _meanRad = [_radiusInfantry, _radiusVehicles, _radiusAir,  _radiusArmor] call BIS_fnc_geometricMean;

    if (DEBUG) then {
        _marker setMarkerText format ["Name: %1 Type: %2 Radius: %3", _name, _type, _meanRad];  // Debug
    };

    // Create Sector if not already captured
    if !(_name in savedCaptures) then {
        
        createMarker [_marker, _pos];
        _marker setMarkerType _markerType;
        _marker setMarkerColor "ColorRed";
        _marker setMarkerSize [0.8, 0.8];   

        //systemChat format ["%1", _meanRad];
        private _trigger = createTrigger ["EmptyDetector", _pos];
        _trigger setTriggerArea [_meanRad, _meanRad, 0, false];
        _trigger setTriggerActivation ["WEST", "PRESENT", true];
        _trigger setTriggerStatements [
            "this && (MAX_ACTIVE_SECTORS > count(ACTIVE_SECTORS)) && !(([thisTrigger] call fnc_triggerToLocationId) in ACTIVE_SECTORS)",
            "
            systemChat 'Proxed';
            [thisTrigger] spawn {
                params['_trigger'];
                [_trigger] execVM 'server\spawner.sqf';
            };
            systemChat 'here...';
            ",
            "hint 'Blufor trigger: Deactivated'"
            ];
        // Stash location ID into the trigger's variables
        _trigger setVariable ["LOCATION_ID", _uid, true];
        _trigger setVariable ["LOCATION_META", [
            _name,
            _pos,
            _type,
            _uid,
            _marker,
            _radiusInfantry,
            _radiusVehicles,
            _radiusAir,
            _radiusArmor,
            _infantryCountRange,
            _vehiclesCountRange,
            _airCountRange,
            _armorCountRange
        ], true];
    } else {
        createMarker [_marker, _pos];
        _marker setMarkerType _markerType;
        _marker setMarkerColor "ColorBlue";
        _marker setMarkerSize [0.8, 0.8];
    };



} forEach LOCATIONS; 

systemChat format["[DEBUG] Dynamic Sectors Established"];

// Start Front-Defence Mode
[] spawn {
    execVM "server\front.sqf";
};
systemChat format["[DEBUG] Front-Defence Mode Started"];

// Start Civilian/Spawn Manager Loop
[] spawn {
    while {true} do {
        execVM "server\civilians.sqf";
        {
            // All non-blufor motorists
            if ((side _x != WEST) && !(isNull objectParent _x)) then {
                (vehicle _x) setFuel 1;
                //(vehicle _x) setDamage 0;
            }
        } forEach allUnits;
        sleep 30;
    };
};
systemChat format["[DEBUG] Civilian/Spawn Manager Started"];

// Zeus auto-add to curator loop
[] spawn
{
    while {true} do // looping
    {
        {
            sleep 5; // wait a while if you have spawn system as "Controlled Spawn and Waypoints Randomizr script".
            _x addCuratorEditableObjects [allUnits, true]; // each unit of all factions/sides will be available on map.
            _x addCuratorEditableObjects [vehicles, true]; // each vehicle of all factions/sides will be available on map.
            sleep 60; // after that first check, wait a bit longer to next loop / saving host/server performance.
        } forEach allCurators; // now repeat the instructions for each Curator.
    };
};
systemChat format["[DEBUG] Zeus auto-add to curator loop Started"];

[] spawn 
{
    while {true} do {
        sleep (selectRandom[300, 600, 900, 1200]);
        [getArray (configfile >> "CfgWorlds" >> worldName >> "centerPosition")] execVM "server\attacks.sqf";
        systemChat format["[DEBUG] Attack Spawned!"];
    };
};