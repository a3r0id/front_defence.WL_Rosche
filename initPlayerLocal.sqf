// 2022 - By A3R0 - initPlayerLocal.sqf - License: MIT

params ["_player", "_didJIP"];

FD_HAS_ADDACTIONS = false;
COMMANDER_NAME    = "Commander@Eule 6";
COMMANDER_TERMINAL= "Land_Laptop_device_F"; // className of object that acts as actions terminal for players.

// Pull a resupply crate from the supply service point
fnc_getCrate = {
    
	params ["_cratename", "_player", "_params"];  
    
	if !(player isEqualTo _player) exitWith {};     
    {
        if (_cratename == (_x select 0)) then {

            private _cratename        = _x select 0; // ex: "at_resupply"
            private _crateobject      = _x select 1; // ex: "Box_NATO_Wps_F"
            private _crateweapons     = _x select 2; // ex: [["rhs_weap_m249_pip_S", 1]]
            private _cratemagazines   = _x select 3; // ex: [["rhs_200rnd_556x45_M_SAW", 1]]
            private _crateitems       = _x select 4; // ex: [["rhs_weap_m249_pip_S", 1]]
			// 
			// [player, 1, 5, 2, 0, 30, 0] call BIS_fnc_findSafePos
            private _crate = createVehicle [_crateobject, getPos player, [], 0, "CAN_COLLIDE"];
            _crate allowDamage false;
            clearItemCargoGlobal     _crate;
            clearWeaponCargoGlobal   _crate;
            clearMagazineCargoGlobal _crate;
            clearBackpackCargoGlobal _crate;                
            {
                _crate addWeaponCargoGlobal _x;
            } forEach _crateweapons;
            {
                _crate addMagazineCargoGlobal _x;
            } forEach _cratemagazines;
            {
                _crate addItemCargoGlobal _x;
            } forEach _crateitems;    

			[_crate, "IS_CRATE", true, true] remoteExec ["setVariable", 0]; 

			[_crate, true, [0, 2, 0], 0, true] remoteExec ["ace_dragging_fnc_setCarryable", 0];

            [_crate, true, [0, 2, 0], 0, true] call ace_dragging_fnc_setCarryable;

			[_player, _crate] call ace_dragging_fnc_startCarry;

        };
    } forEach FD_supply_crates;
    
    _crate
};

// Pull a static weapon from the heavy weapons crate
fnc_getStaticWeapon = {
    
	params["_weapon", "_player"];
    
	if !(player isEqualTo _player) exitWith {};

	// [player, 1, 5, 2, 0, 30, 0] call BIS_fnc_findSafePos
    _object0 = createVehicle [_weapon, getPos player, [], 0, "CAN_COLLIDE"];

    [_object0, [], [], true] call BIS_fnc_initVehicle;

    [_object0, "IS_ASSET", true, true] remoteExec ["setVariable", 0]; 

    [_object0, true, [0, 2, 0], 0, true] remoteExec ["ace_dragging_fnc_setCarryable", 0];

    [_object0, true, [0, 2, 0], 0, true] call ace_dragging_fnc_setCarryable;

    [_player, _object0] call ace_dragging_fnc_startCarry;

    hint "Grabbed Static Weapon";

    _object0
};

_groupId  = groupId group player;

//if (_groupId in COMMANDER_NAME) then {
    /*
    * Argument:
    * 0: Object the action should be assigned to <OBJECT>
    * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
    * 2: Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
    * 3: Action <ARRAY>
    */
    // RESUPPLY CRATES
    private _resupplyRootMenu = [
        "resupplyMenuRoot",
        "Resupply",
        "",
        {}, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions"], _resupplyRootMenu] call ace_interact_menu_fnc_addActionToClass;   
    private _action = [
        "ace_resupply_mixed_crate",
        "Mixed Resupply",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _crate = ["general_resupply", _player, []] call fnc_getCrate;
            hint "Grabbed Mixed Resupply";
            // Pickup the crate
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "resupplyMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;
    private _action = [
        "ace_resupply_medical_crate",
        "Medical Resupply",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _crate = ["medical_resupply", _player, []] call fnc_getCrate;
            hint "Grabbed Medical Resupply";
            // Pickup the crate
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "resupplyMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;     
    private _action = [
        "ace_resupply_at_crate",
        "AT Resupply",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _crate = ["at_resupply", _player, []] call fnc_getCrate;
            hint "Grabbed AT Resupply";
            // Pickup the crate
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "resupplyMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;      
    private _action = [
        "ace_resupply_empty_crate",
        "Empty Resupply",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _crate = ["empty_resupply", _player, []] call fnc_getCrate;
            hint "Grabbed Empty Resupply";
            // Pickup the crate
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "resupplyMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;      


    // STATIC WEAPONS SPAWNER
        private _staticSpawnerRootMenu = [
        "staticSpawnerMenuRoot",
        "Static Weapons",
        "",
        {}, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions"], _staticSpawnerRootMenu] call ace_interact_menu_fnc_addActionToClass;   
    private _action = [
        "Grab TOW Launcher",
        "TOW Launcher",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _weapon = ["RHS_TOW_TriPod_USMC_D", _player] call fnc_getStaticWeapon;
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "staticSpawnerMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;      
    private _action = [
        "Grab AA Pod",
        "AA Pod",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _weapon = ["RHS_Stinger_AA_pod_USMC_D", _player] call fnc_getStaticWeapon;
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "staticSpawnerMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;   
    private _action = [
        "Grab MK19",
        "MK19",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _weapon = ["RHS_MK19_TriPod_USMC_D", _player] call fnc_getStaticWeapon;
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "staticSpawnerMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;
    private _action = [
        "Grab Mortar",
        "Mortar",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _weapon = ["B_T_Mortar_01_F", _player] call fnc_getStaticWeapon;
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "staticSpawnerMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;    
    private _action = [
        "Grab M2 Static",
        "M2 Static",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _weapon = ["RHS_M2StaticMG_D", _player] call fnc_getStaticWeapon;
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "staticSpawnerMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;       
    private _action = [
        "Grab M2 Static Mini",
        "M2 Static Mini",
        "",
        {
            if !(player isEqualTo _player) exitWith {};
            _weapon = ["RHS_M2StaticMG_MiniTripod_D", _player] call fnc_getStaticWeapon;
        }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
    ["US_WarfareBVehicleServicePoint_Base_EP1" , 0, ["ACE_MainActions", "staticSpawnerMenuRoot"], _action] call ace_interact_menu_fnc_addActionToClass;          

    // Terminal - Build Menu //////////////////////////////
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions"], [
    "openBuildMenu",
    "Purchase Menu",
    "",
    {
        PURCHASE_MENU_OPEN = true;
        [_player] execVM "client\build_menu.sqf";            
    }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;     


    // Terminal - FOB Menu ///////////////////////////////
    _menuRoot = [ "fobMenuRoot", "FOB Menu", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions"], _menuRoot] call ace_interact_menu_fnc_addActionToClass;    


    // Terminal - Build FOB
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions", "fobMenuRoot"], [
    "openBuildFob",
    "Build FOB",
    "",
    {
        private _check_fob = [] call fnc_getFobLocation;
        if (_check_fob isEqualTo false) then {
            [] spawn {
                private _result = ["Forward Operations Base is ready to be built. Would you like to continue?", "Confirm", true, true] call BIS_fnc_guiMessage;
                if (_result) then {
                    hint "Select a position on the map to deploy the FOB";
                    openMap true;
                    player onMapSingleClick {
                        onMapSingleClick '';
                        [[_pos], "server\compositions\fobs\fob.sqf"] remoteExec ["execVM", 2];
                        hint "FOB Deployed";
                        player setPos _pos;
                        openMap false;
                        true
                    };
                };	                
            };	
        } else {
            hint "FOB is already deployed.";
        };        
    }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;         

    // Terminal - Destroy FOB
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions", "fobMenuRoot"], [
    "openDestroyFob",
    "Dismantle FOB",
    "",
    {
        private _check_fob = [] call fnc_getFobLocation;
        if (_check_fob isEqualTo false) then {
            hint "FOB is not deployed";
        } else {
            [] spawn {
                private _result = ["Forward Operations Base is ready to be dismantled. Would you like to continue?", "Confirm", true, true] call BIS_fnc_guiMessage;
                if (_result) then {
                    [[], "server\compositions\delete_composition\delete_fob.sqf"] remoteExec ["execVM", 2];
                    hint "FOB Dismantled!";
                };                
            };
        };        
    }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;         

    // Terminal - FOP Menu ///////////////////////////////
    _menuRoot = [ "fopMenuRoot", "FOP Menu", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions"], _menuRoot] call ace_interact_menu_fnc_addActionToClass;    

    // Terminal - Build FOP
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions", "fopMenuRoot"], [
    "openBuildFop",
    "Build FOP",
    "",
    {
        private _check_fop = [] call fnc_getFopLocation;
        if (_check_fop isEqualTo false) then {
            [] spawn {
                private _result = ["Forward Outpost is ready to be built. Would you like to continue?", "Confirm", true, true] call BIS_fnc_guiMessage;
                if (_result) then {
                    hint "Select a position on the map to deploy the FOP";
                    openMap true;
                    player onMapSingleClick {
                        onMapSingleClick '';
                        [[_pos], "server\compositions\fops\fop.sqf"] remoteExec ["execVM", 2];
                        hint "FOP Deployed";
                        player setPos _pos;
                        openMap false;
                        true
                    };
                };                
            };
        } else {
            hint "FOP is already deployed";
        };
    }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;         

    // Terminal - Destroy FOP
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions", "fopMenuRoot"], [
    "openDestroyFop",
    "Dismantle FOP",
    "",
    {
        private _check_fop = [] call fnc_getFopLocation;
        if (_check_fop isEqualTo false) then {
            hint "FOP is not deployed";
        } else {
            [] spawn {
                private _result = ["Forward Outpost is ready to be dismantled. Would you like to continue?", "Confirm", true, true] call BIS_fnc_guiMessage;
                if (_result) then {
                    [[], "server\compositions\delete_composition\delete_fop.sqf"] remoteExec ["execVM", 2];
                    hint "FOP Dismantled!";
                };                
            };
        };
    }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;     

    // Terminal - FOP Menu ///////////////////////////////
    _menuRoot = [ "logiMenuRoot", "Logistics Menu", "", {}, {true}] call ace_interact_menu_fnc_createAction;
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions"], _menuRoot] call ace_interact_menu_fnc_addActionToClass;        

    // Terminal - Deploy To FOP
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions", "logiMenuRoot"], [
    "doTeleportFobToFop",
    "Deploy To Forward Outpost",
    "",
    {
		private _fop_lo = [] call fnc_getFopLocation;
		if (_fop_lo isEqualTo false) then {
			hint "No Forward Outpost Location Set! Is a Forward Outpost present?";
		} else {
			player setPos _fop_lo;
		};        
    }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;         

    // Terminal - Create Drone
    [COMMANDER_TERMINAL, 0, ["ACE_MainActions", "logiMenuRoot"], [
    "doCreateDrone",
    "Create Drone (CLEAR SPAWN AREA!!!)",
    "",
    {
        private _drone = "ITC_Land_B_UAV_AR2i";
        [[player, _drone], "server\spawn_drone.sqf"] remoteExec ["execVM", 2];
    }, {true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToClass;       

//};

