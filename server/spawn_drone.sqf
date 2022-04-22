params ["_player", "_drone"];
private _spawnPos        = [_player, 5] call fnc_inFrontOf;
private _drone_object    = createVehicle [_drone, _spawnPos, [], 0, "NONE"];
createVehicleCrew _drone_object;
[format["%1 create a drone. Model: %2 Grid: %3", name _player, _drone, mapGridPosition _player]] call void_globalChat;