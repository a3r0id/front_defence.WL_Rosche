params["_pos"];

if (typeName BLUFOR_MEAN_POS == "BOOL") exitWith {systemChat format ["Attacks.sqf -> Error, Exiting: %1 | BF mean pos: ", BLUFOR_MEAN_POS]};

[_pos] spawn {
	params["_pos"];
	private _groups    = [];
	private _groupType = selectRandom(["battle_cav"]);//selectRandom(["air_raid", "battle_group"]);
	switch (_groupType) do {

		case "air_raid": {
			_amount = random 5;
			if (_amount == 0) then {_amount = 1};
			for "_i" from 0 to _amount do {
				_vehType = selectRandom (FD_OPFOR_AIR);
				_vehicle = createVehicle [_vehType, [[0, 0, 500], [[[_pos, 150]], []] call BIS_fnc_randomPos] call BIS_fnc_vectorAdd, [], 500, "FLY"];
				createVehicleCrew _vehicle;
				// Unlimited Ammo for all vehicles.
				_vehicle addEventHandler ["Fired", {(_this select 0) setVehicleAmmo 1}];
				_groups pushBack _vehicle;
				{_x setVariable ["IS_MANAGED", true, true]} forEach (crew _vehicle);
				_group = group ((crew _vehicle) select 0);
				_group allowFleeing 0;
				deleteWaypoint [_group, (currentWaypoint _group)];
				private _wp = _group addWaypoint [BLUFOR_MEAN_POS, 10, (currentWaypoint _group) + 1, "attack_waypoint"];
				_wp setWaypointBehaviour "COMBAT";
				_wp setWaypointType "SAD";
				//_wp setWaypointVisible true; // debug
				_wp setWaypointFormation "NO CHANGE";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointSpeed "FULL";
				_wp setWaypointTimeout [8, 9, 10];
				//_wp setWaypointLoiterType "CIRCLE_L";	
			};

			sleep 25;

			while {{ alive _x } count (flatten _groups) > 0} do 
			{
				if (typeName BLUFOR_MEAN_POS != "BOOL") then
				{

					{
						private _veh              = _x;
						private _targets          = [];
						{
							if ((_veh distance _x) < 1500) then {
								_targets pushBack _x;
							}; 
						} forEach allPlayers;
						systemChat format ["Potential targets: %1", _targets];
						if ((count _targets) > 0) then {
							deleteWaypoint [group _x, (currentWaypoint group _x)];
							private _target = selectRandom _targets;
							(crew _x) doTarget _target;
							(crew _x) doFire   _target;
							systemChat format ["Attacks.sqf -> %1 is attacking %2", group (driver _x), _target];
						};
					} forEach _groups;	

				};
				sleep 10;
			};		
		};

		case "battle_cav": {
			_amount = random 10;
			if (_amount == 0) then {_amount = 1};
			for "_i" from 0 to _amount do {
				_vehType = selectRandom (FD_OPFOR_CAR + FD_OPFOR_ARMOR);
				_vehicle = createVehicle [_vehType, [_pos, 5, 50, 5, 0, 30, 0] call BIS_fnc_findSafePos, [], 500, "NONE"];
				createVehicleCrew _vehicle;
				// Unlimited Ammo for all vehicles.
				_vehicle addEventHandler ["Fired", {(_this select 0) setVehicleAmmo 1}];				
				_groups pushBack _vehicle;
				{_x setVariable ["IS_MANAGED", true, true]} forEach (crew _vehicle);
				_group = group ((crew _vehicle) select 0);
				_group allowFleeing 0;
				deleteWaypoint [_group, (currentWaypoint _group)];
				private _wp = _group addWaypoint [BLUFOR_MEAN_POS, 10, (currentWaypoint _group) + 1, "attack_waypoint"];
				_wp setWaypointBehaviour "COMBAT";
				_wp setWaypointType "SAD";
				//_wp setWaypointVisible true; // debug
				_wp setWaypointFormation "NO CHANGE";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointSpeed "FULL";
				_wp setWaypointTimeout [150, 200, 300];
				//_wp setWaypointLoiterType "CIRCLE_L";	
			};		

			sleep 300;	

			while {{ alive _x } count (flatten _groups) > 0} do 
			{
				if (typeName BLUFOR_MEAN_POS != "BOOL") then
				{
					{
						private _veh              = _x;
						private _targets          = [];
						{
							if ((_veh distance _x) < 1500) then {
								_targets pushBack _x;
							}; 
						} forEach allPlayers;
						systemChat format ["Potential targets: %1", _targets];
						if ((count _targets) > 0) then {
							deleteWaypoint [group _x, (currentWaypoint group _x)];
							private _target = selectRandom _targets;
							(crew _x) doTarget _target;
							(crew _x) doFire   _target;
							systemChat format ["Attacks.sqf -> %1 is attacking %2", group (driver _x), _target];
						};
					} forEach _groups;	
				};
				sleep 30;
			};							
		};
		
		default {};
	};
	systemChat format ["%1 %2 %3", "Attack group ", _groupType, "is dead."];	
};
systemChat "Started new thread: Attacks.sqf";