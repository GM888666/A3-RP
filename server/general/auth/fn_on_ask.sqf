/*
* A3-RP
* Server-side
* file: on_ask.sqf
* desc: The client asks if he is already in the database, answer needed
*/

private _player = param [0, objNull];

["[fn_on_ask]: Request from client received"] call SRV_fnc_log_me;