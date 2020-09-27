class Authentification {
	tag = "auth";
	class Functions {
		file = "auth";
		class ask_account {};
		class ask_players {};
		class on_client_account_id {};
		class on_players_list {};
		class update_player {};
	};
};

class General {
	tag = "client";
	class Functions {
		file = "general\functions";
		class log_me {};
		class cam_intro {};
	};
	class Main {
		file = "general\main";
		class init {};
	};
	class player_list {
		file = "dialog\players_list";
		class players_list_play {};
		class players_list_set {};
		class players_list_on_load {};
	};
};