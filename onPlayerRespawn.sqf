params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

private _unitRole = roleDescription _newUnit;

private _isCommand = false;

if (_unitRole == COMMANDER_NAME) then {
	_isCommand = true;
};

// Remove old addactions etc from corp. - KC Liberation - github.com/illahpotatoes
if (!isNull _oldUnit) then {
	_newUnit synchronizeObjectsRemove [_oldUnit];
	_oldUnit synchronizeObjectsRemove [_newUnit];
};

private _foblo = [] call fnc_getFobLocation;
private _foplo = [] call fnc_getFopLocation;
systemChat format["[COMMAND] FOB: %1, FOP: %2", _foblo, _foplo];

"FOB_LOCATION" addPublicVariableEventHandler {};
"FOP_LOCATION" addPublicVariableEventHandler {};

if !(_foblo isEqualTo false) then {
	_newUnit setPos _foblo;
};

// Enable systemChat - hotfix
if (not shownchat) then {showchat true;};