{ lib, config, ... }:

{
	options.user = {
		enable = lib.mkEnableOption "Enables user configuration.";

		users = lib.mkOption {
			type = lib.types.listOf (lib.types.submodule {
				options = {
					username = lib.mkOption {
						type = lib.types.str;
						description = "Username for the user.";
					};

					wheel = lib.mkEnableOption "Set whether the user has sudo priviledges.";

					extraGroups = lib.mkOption {
						type = lib.types.listOf lib.types.str;
						default = [];
						description = "Extra groups for the user (in addition to automatic ones).";
					};
				};
			});
			description = "List of user accounts to configure.";
		};
	};

	config = lib.mkIf config.user.enable {
		users.users = lib.listToAttrs (map (user: {
			name = user.username;
			value = {
				isNormalUser = true;
				initialPassword = "nixos";
				extraGroups = lib.mkMerge [
					(lib.mkIf user.wheel
						(lib.mkMerge [
							[ "wheel" "input" ]
							(if config.system.virtualization.program == "virtualbox" then [ "vboxsf" ] else [])
							(if config.system.audio.enable then [ "audio" ] else [])
							(if config.hardware.graphics.enable then [ "video" ] else [])
						])
					)
					user.extraGroups
				];
			};
		}) config.user.users);
	};
}

