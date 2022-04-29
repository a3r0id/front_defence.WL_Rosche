while {(missionNamespace getVariable ["IS_FRONT_DEFENCE", false]) == true} do {
	
	private _frontmarker = "_front_marker";
	deleteMarker _frontmarker;
	deleteMarker "_blufor_marker";
	deleteMarker "_opfor_marker";
	deleteMarker "bf_mark_test";

	private _blufor = allUnits select {side _x == WEST};
	private _opfor  = allUnits select {side _x == EAST};

    // If there is OPFOR & BLFOR THEN START THE FRONT DEFENCE ELSE IDLE
	if (count _opfor > 0 && count _blufor > 0) then {


		private _bfpos  = [];
		private _bfx    = [];
		private _bfy    = [];
		{
			try{
				private _x_ = getPos _x select 0;
				private _y_ = getPos _x select 1;
				if (typeName _x_ == "SCALAR") then {_bfx pushBack _x_};
				if (typeName _y_ == "SCALAR") then {_bfy pushBack _y_};
			} catch {};
		} forEach _blufor;
		
		private _bfxmean    = _bfx call BIS_fnc_arithmeticMean;
		private _bfymean    = _bfy call BIS_fnc_arithmeticMean;

		missionNamespace setVariable ["BLUFOR_MEAN_POS", [_bfxmean, _bfymean, 0], true];

		private _ofpos  = [];
		private _ofx    = [];
		private _ofy    = [];		
		{
			try{
				private _x_ = getPos _x select 0;
				private _y_ = getPos _x select 1;
				if (typeName _x_ == "SCALAR") then {_ofx pushBack _x_};
				if (typeName _y_ == "SCALAR") then {_ofy pushBack _y_};
			} catch {};
		} forEach _opfor;

		private _ofxmean    = _ofx call BIS_fnc_arithmeticMean;
		private _ofymean    = _ofy call BIS_fnc_arithmeticMean;

		missionNamespace setVariable ["OPFOR_MEAN_POS", [_ofxmean, _ofymean, 0], true];

		private _ofmarker = createMarker ["_opfor_marker", [_ofxmean, _ofymean]]; // Not visible yet.
		_ofmarker setMarkerType "mil_objective"; // Visible.
		_ofmarker setMarkerColor "ColorRed"; // Blue.
		_ofmarker setMarkerText "OPFOR Front";

		private _bfmarker = createMarker ["_blufor_marker", [_bfxmean, _bfymean]]; // Not visible yet.
		_bfmarker setMarkerType "mil_objective"; // Visible.
		_bfmarker setMarkerColor "ColorBlue"; // Blue.
		_bfmarker setMarkerText "BLUFOR Front";	


		// get relative position of blufor and opfor
		_difx = 0;
		_dify = 0;

		
		if (_bfxmean > _ofxmean) then {
			_difx = ((_bfxmean - _ofxmean) / 2) + _ofxmean;
		} else {
			_difx = ((_ofxmean - _bfxmean) / 2) + _bfxmean;
		};

		if (_bfymean > _ofymean) then {
			_dify = ((_bfymean - _ofymean) / 2) + _ofymean;
		} else {
			_dify = ((_ofymean - _bfymean) / 2) + _bfymean;
		};
		

		private _front = [_difx, _dify];

		missionNamespace setVariable ["FRONT_POS", _front, true];

		private _frontmarker = createMarker [_frontmarker, _front];
		_frontmarker setMarkerType "mil_objective";
		_frontmarker setMarkerColor "ColorYellow";	
		_frontmarker setMarkerText "Calculated Frontline";

		private _angle    = 10;//will place objects every 10°

		private _qstd     = "bf_quantized_marker_";
		private _ostd     = "of_quantized_marker_";

		private _bfdistance =  (getMarkerPos "_blufor_marker") distance (getMarkerPos _frontmarker);
		missionNamespace setVariable ["BLUFOR_DISTANCE", _bfdistance, true];
		private _ofdistance =  (getMarkerPos "_blufor_marker") distance (getMarkerPos _frontmarker);
		missionNamespace setVariable ["OPFOR_DISTANCE", _ofdistance, true];

		for "_i" from 0 to (360-_angle) step _angle do {

			private _bf_x_c     = _bfdistance * cos(_i) + _bfxmean;
			private _bf_y_c     = _bfdistance * sin(_i) + _bfymean;
			private _of_x_c     = _ofdistance * cos(_i) + _ofxmean;
			private _of_y_c     = _ofdistance * sin(_i) + _ofymean;

			private _of_markername = format ["%1%2", _qstd, _i];
			private _bf_markername = format ["%1%2", _ostd, _i];

			deleteMarker _bf_markername;
			deleteMarker _of_markername;

			private _frontmarker_test_bf = nil;
			private _frontmarker_test_of = nil;

			_frontmarker_test_bf = createMarker [_bf_markername, [_bf_x_c, _bf_y_c]];
			_frontmarker_test_bf setMarkerType "mil_dot";
			_frontmarker_test_bf setMarkerSize [0.5, 0.5];
			_frontmarker_test_bf setMarkerColor "Colorwhite";	
	
			_frontmarker_test_of = createMarker [_of_markername, [_of_x_c, _of_y_c]];
			_frontmarker_test_of setMarkerType "mil_dot";
			_frontmarker_test_of setMarkerSize [0.5, 0.5];
			_frontmarker_test_of setMarkerColor "Colorwhite";		

		};


		// These guys are like linebackers, they are coming from the outside and sweep into the front.
		{
			// Redundant checks - hotfix :(
			if !(side _x isEqualTo east) then {continue};

			// !([_x] call fnc_groupHasVehicle)

			// If far from front then move to frontoline.
			if (([_x] call fnc_groupMedianPosition) distance _front > _ofdistance * 2) then 
			{
				// If OPFOR unit (not in vehicle) is outside the calculated front, direct them towards the calculated front.
				deleteWaypoint [_x, (currentWaypoint _x)]; // Replace the current waypoint
				private _group = _x;
				{
					deleteWaypoint _x;
				} forEach (waypoints _group);

				private _rnpos = [_front, _ofdistance] call fnc_randPosSafe;

				private _general_fronts_radians = [_ofdistance, _bfdistance] call BIS_fnc_arithmeticMean;

				private _wp = _x addWaypoint [_rnpos, _general_fronts_radians / 2, (currentWaypoint _x) + 1, "move_to_front"];

				_wp setWaypointBehaviour "COMBAT";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointFormation "NO CHANGE";
				_wp setWaypointSpeed "FULL";
				_wp setWaypointTimeout [120, 300, 600];
				_wp setWaypointType "SAD";
				_wp setWaypointLoiterRadius _general_fronts_radians;
				_wp setWaypointLoiterType "CIRCLE_L";		

				systemChat format["%1 is outside the calculated front. Moving to the front.", _x];	

			} else { // If inside the calculated front, task defend the frontlines.
				if (selectRandom[true, false, false, false]) then {
					[_group, _front] call bis_fnc_taskDefend;
					systemChat format["%1 is defending the frontlines.", _x];
				};
			};

			// is: opfor/alive/not ignored or managed.
		} forEach allGroups findif {
			({ alive _x } count units _x > 0 ) 
			&& (side (leader _x) isEqualTo east) 
			&& !([_x] call fnc_shouldIgnoreGroupByVehicleIndication)
			&& (_x getVariable["IS_MANAGED", false] == false)
		};
	};
	sleep 10;
};


