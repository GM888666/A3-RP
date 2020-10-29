/**
* A3-RP
* Server-side
* file: on_insert_vehicle.sqf
* desc: Call insert vehicle in database
*/

params [
	["_client_player_id", 0, [0]],
	["_vehicle", objNull, [objNull]]
];

private _vehicle_classname 	= typeOf _vehicle;
private _vehicle_damage 	= str(getAllHitPointsDamage _vehicle select 2);
private _vehicle_pos		= getPosATL _vehicle;
private _vehicle_dir		= getDir _vehicle;

private _res = [_vehicle_classname, _vehicle_damage, _vehicle_pos, _vehicle_dir] call SRV_fnc_insert_vehicle;

private _vehicle_id = _res select 0;

private _res2 = [_vehicle_id, _client_player_id] call SRV_fnc_insert_vehicle_key;

_vehicle_id