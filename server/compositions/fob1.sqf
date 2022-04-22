/*
Grab data:
Mission: front_defence
World: WL_Rosche
Anchor position: [6886.17, 14923.4]
Area size: 150
Using orientation of objects: no
*/

/*
[[6364.04, 13528.2, 64.74], 150, false] call BIS_fnc_objectsGrabber;

TODO:
> respawn needs to be renamed to respawn_west in this file
> vehicle respawn needs to be renamed to vehicle_respawn_west in this file
> vehicles should be spawned on available CUP_A1_Road_VoidPathXVoidPath's
> 
*/

private _things_to_delete = [FOB_TELEPORTER, INITIAL_CRATE, OTHER_FLAG, respawn_west];

deleteMarker "fob_marker";
{
	deleteVehicle _x;
} forEach _things_to_delete;

params["_pos"];

_items = [
	["Land_HBarrier_Big_F",[-4.70703,-0.771484,-0.000776291],180,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_Big_F",[-1.4082,-5.875,-0.000967026],89.9878,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_Cargo_Patrol_V1_F",[-4.38379,-4.92676,0.0133495],270,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["B_GAF2_A6_Med_Fleck",[3.65039,-8.58887,-2.09808e-005],359.998,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_3_F",[-4.53857,-8.95117,-0.0104198],0,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["B_GAF2_IFV_Puma_Fleck",[1.76123,10.3828,-0.115157],359.999,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_5_F",[-8.8374,-1.20996,-0.0145378],134.99,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["BWA3_Dingo2_FLW200_M2_CG13_Fleck",[-4.56641,10.0127,0.00700378],359.997,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_WaterBarrel_F",[-2.85107,-12.2822,0.000900269],195.026,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["ITC_Land_B_UAV_AR2i",[-8.89502,9.80469,-0.00163746],359.995,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["B_GAF2_AA_Fleck",[8.854,10.2051,-0.113815],359.999,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_Big_F",[-1.09229,-14.0879,0.0037117],270,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["B_GAF2_HEMMT_MED_Trop",[9.91016,-11.2305,0.0370998],359.996,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_5_F",[-12.4614,-4.84375,-0.0643959],134.987,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_3_F",[-14.5713,-5.16504,0.0243664],225.009,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["B_supplyCrate_F",[-8.72705,-13.5049,0.000858307],359.994,1,0,[],"","[this, true] call ace_arsenal_fnc_initBox;this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_3_F",[-14.853,-8.66016,-0.0324078],45.0009,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_Big_F",[-15.7646,6.1543,-0.000692368],180,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_ToiletBox_F",[-16.1772,-5.67969,0.00129509],134.988,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Barrels",[-3.19189,-16.9111,0.00132751],270,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_CratesShabby_F",[-16.6958,-6.78711,0.000926971],314.987,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_CratesShabby_F",[-16.959,-7.57129,0.00056076],225.013,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_CratesPlastic_F",[-17.4995,-7.0459,0.000253677],134.987,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Barrels",[-15.9351,-10.2031,0.000743866],134.978,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["B_GAF2_AR2_Darter_Fleck",[16.6191,-9.39648,-0.00211143],359.999,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_3_F",[-14.3379,-11.1025,-0.0145206],134.978,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Barrels",[-17.0757,-9.05469,0.000675201],225.013,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_Big_F",[-4.33496,-19.1348,0.00259209],1.36627e-005,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["RHS_M2A3_BUSKIII_wd",[-17.0122,11.2959,-0.0709782],0.00472193,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["ModuleRespawnPosition_F",[-20.9678,-3.50293,0],0,1,0,[],"respawn_west","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_3_F",[-21.1978,4.68652,-0.0234795],89.9951,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["WNZ_ACMLS_21",[20.1216,10.7646,-0.0998573],359.999,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["B_GAF2_Truck_Ammo_Fleck",[21.6323,-10.1797,-0.0480804],359.993,1,0,[],"","this setVariable ['IS_FOB', true, true];this setVariable ['ace_rearm_isSupplyVehicle', true, true];",true,false], 
	["Land_Wreck_HMMWV_F",[-11.0972,-21.7344,0.0113525],1.70733e-005,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_Big_F",[-24.1396,5.9043,-0.00121117],180,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Fort_Crate_wood",[-20.9165,-13.4883,0.000305176],180,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_TTowerSmall_1_F",[-24.1553,-6.30859,0.00200081],180,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_Cargo_House_V1_F",[-26.0454,-9.55078,0.00606537],255,1,0,[],"","this setVariable ['ace_medical_isMedicalFacility', true, true];this setVariable ['IS_FOB', true, true];",true,false], 
	["rhsusf_stryker_m1127_m2_wd",[-24.7979,11.9189,0.00147438],359.999,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["mas_ger_add_FlagCarrier_ger",[-19.0454,-20.2637,0.00631332],0,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_1_F",[-27.8828,-0.541992,0.000497818],164.993,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_1_F",[-27.8809,2.83301,0.000156403],180,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["mas_usl_add_FlagCarrier_us",[-19.9189,-20.1084,0],0,1,0,[],"FOB_TELEPORTER","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_5_F",[-26.4209,-5.50391,-0.0122604],164.993,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["B_GAF2_Truck_Repair_Fleck",[27.8325,-9.94238,-0.00147438],0.000167885,1,0,[],"","this setVariable['ACE_isRepairVehicle', true, true];this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_Big_F",[-26.1489,-14.2666,0.00205421],344.997,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["HMCS_VW1",[28.6816,8.89844,-0.173329],0.00155538,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["rhsusf_mrzr4_d",[-30.3618,2.63379,0.00220871],359.998,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_Loudspeakers_F",[-28.0601,-13.3135,-0.000724792],256,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["Land_HBarrier_Big_F",[-30.6558,-10.1904,0.00102997],255.002,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["rhsusf_mrzr4_d",[-33.3198,2.62402,0.00336647],359.998,1,0,[],"","this setVariable ['IS_FOB', true, true];",true,false], 
	["ModuleRespawnVehicle_F",[91.3281,16.7197,0],0,1,0,[],"respawn_vehicle_west","this setVariable ['IS_FOB', true, true];",true,false]
];


private _initScript = "";

{
	private _p = [] call fnc_randPos;
	private _veh = _x createVehicle _p;
	[[_veh], "server\asset.sqf"] remoteExec ["execVM", 2];
	systemChat format ["%1 spawned at %2", _veh, _p];
} forEach ([profileNameSpace, "SAVED_PURCHASED_VEHICLES", []] call BIS_fnc_getServerVariable);

systemChat format["%1", _pos];

profileNameSpace setVariable ["SAVED_FOB_LOCATION", [_pos select 0, _pos select 1, _pos select 2]];
missionNameSpace setVariable ["FOB_LOCATION", [_pos select 0, _pos select 1, _pos select 2], true];

[_pos, 0, _items, 0] call BIS_fnc_objectsMapper;

private _marker = createMarker ["fob_marker", [_pos select 0, _pos select 1]]; // Not visible yet.
_marker setMarkerType "hd_flag"; // Visible.
_marker setMarkerColor "ColorYellow"; // Blue.
_marker setMarkerText "FOB Alpha"; // Text.

publicVariable "FOB_LOCATION";