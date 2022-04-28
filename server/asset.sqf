// "server\asset.sqf"
params["_vehicle", ["_storedInit", ""], ["_storedInitTargets", 0], ["_doesRespawn", true], ["_invincible", false], ["_unlimitedAmmo", false]];

// Set networked vehicle data
_vehicle setVariable ["IS_ASSET",       true, 			 true];
_vehicle setVariable ["IS_FOB",       true, 			 true];
_vehicle setVariable ["SPAWN_LOCATION", getPos _vehicle, true];
_vehicle setVariable ["DOES_RESPAWN",   _doesRespawn,    true];

if (_doesRespawn) then {
	_vehicle respawnVehicle [5, 0];
	[_vehicle, [5, 0]] remoteExec ["respawnVehicle", 0];
};

if (_invincible) then {
	_vehicle allowDamage false;
	[_vehicle, false] remoteExec ["allowDamage", 0];
};

if (_unlimitedAmmo) then {
	_vehicle addEventHandler ["Fired", {(_this select 0) setVehicleAmmo 1}];
	[_vehicle, ["Fired", {(_this select 0) setVehicleAmmo 1}]] remoteExec ["addEventHandler", 0];
};



