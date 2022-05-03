// https://community.bistudio.com/wiki/Initialization_Order

// Misc Settings
call compileFinal preprocessFile "config\defaults.sqf";

// Supply crates and supplies
call compileFinal preprocessFile "config\supplies.sqf";

// Schema for assets in purchase menu:
// [class, name, price, description, init, initscope(remoteexec)?]
call compileFinal preprocessFile "config\blufor_purchase_items.sqf";

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
	systemChat format ["[CLIENT] GOT FOP LOCATION: %1", _fop];
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
	systemChat format ["[CLIENT] GOT FOB LOCATION: %1", _fob];
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

fnc_hasObstruction = {
	params["_pos", ["_radius", 1]]; // Default Radius: 1 meter
	_hasObstruction = false;
	private _nearbyObjects = nearestObjects [_pos, [], _radius];
	systemChat format ["NEARBY OBSTRUCTIONS: %1", _nearbyObjects];
	if ((count _nearbyObjects) > 1 ) then {
		_hasObstruction = true;
	};
	_hasObstruction
};

fnc_getEmptySpawnPad = {
    private _padPos     = false;
    {
        if (typeOf _x isEqualTo "CUP_A1_Road_VoidPathXVoidPath") then {
			systemChat format ["Obstructed: %1", [getPos _x, 5] call fnc_hasObstruction];
            if !([getPos _x, 5] call fnc_hasObstruction) then {
                _padPos = getPos _x;
                break;
            };
        };
    } forEach allMissionObjects "";
    _padPos
};

fnc_saveGet_Server = {
	// Get Variable or false - persistant - server
	params["_var"];
	profileNamespace getVariable [_var, false]
};

fnc_saveSet_Server = {
	// Set persistant variable - server
	params["_var", "_value", ["_is_public", true]];
	profileNamespace setVariable [_var, _value, _is_public];
};

fnc_saveGet_Client = {
	// Get Variable or false - persistant - client
	params["_var"];
	[profileNamespace, _var, false] spawn BIS_fnc_getServerVariable
};

fnc_saveSet_Client = {
	// Set persistant variable - client
	params["_var", "_value", ["_is_public", true]];
	[profileNamespace, _var, _value] spawn BIS_fnc_setServerVariable;
	if (_is_public) then {
		publicVariable _var;
	};
};
