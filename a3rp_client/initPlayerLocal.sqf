/**
* A3-RP
* Client-side
* file: initPlayerLocal.sqf (https://community.bistudio.com/wiki/Event_Scripts#initPlayerLocal.sqf)
* desc: Handle auth and variables for the player. Executed after initServer.sqf
*/

if (!isMultiplayer) exitWith {};

/**
* Black screen
*/
0 cutText[localize "STR_loading", "BLACK FADED", 99999999];

client_log_me_id				= 0;
client_account_id_received 		= false;
client_players_list_received 	= false;
client_ready_to_play 			= false;
client_player_selected 			= false;
client_player_spawn_selected 	= false;
client_player_gear_loaded		= false;

["Server is loading..."] call client_fnc_log_me;

/**
* Wait until the server is ready
*/
waitUntil {SRV_is_ready};
["The server is ready"] call client_fnc_log_me;

waitUntil {!isNull player};

/**
* Ask database if account exist, if not, create it, then send back client ID
*/
["Asking account to the server..."] call client_fnc_log_me;
call auth_fnc_ask_account;
waitUntil {client_account_id_received};
["The account is ready"] call client_fnc_log_me;

/**
* Ask database if account has existing players in database
*/
["Asking the list of player of this account to the server..."] call client_fnc_log_me;
call auth_fnc_ask_players;
waitUntil {client_players_list_received};

/**
* Display cam sequence, then character selection, spawn
*/
waitUntil {!isNull (findDisplay 46)};
call client_fnc_cam_intro;
waitUntil {player getVariable ["client_cam_ready", false]};

/**
* Character selection
*/
createDialog "A3RP_player_list";
waitUntil {client_player_selected};

/**
* Load gear
*/
call client_fnc_load_gear;
waitUntil {client_player_gear_loaded};

["Setting up Event Handlers"] call client_fnc_log_me;
call client_fnc_init_eventhandler;

/**
* Spawn selection
*/
if (client_player_position isEqualTo [0,0,0]) then {
	createDialog "A3RP_spawn_menu";
} else {
	[player, client_player_position, client_player_dir] remoteExec ["SRV_fnc_teleport_me", 2];
	player setVariable ["client_cam_intro_running", false];
};