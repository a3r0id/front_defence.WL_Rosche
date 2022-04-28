params ["_player", "_drone"];
private _spawnPos        = [_player, 1.5] call fnc_inFrontOf;
private _drone_object    = createVehicle [_drone, _spawnPos, [], 0, "NONE"];
createVehicleCrew _drone_object;
_player addItem "B_UavTerminal";
_player assignItem "B_UavTerminal";
[format["%1 create a drone. Model: %2 Grid: %3", name _player, _drone, mapGridPosition _player]] call void_globalChat;