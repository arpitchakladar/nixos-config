{ lib, config, ... }:

{
	options.user = {
		enable = lib.mkEnableOption "Enables user configuration.";
		username = lib.mkOption {
			type = lib.types.str;
			description = "Sets username for the default user.";
		};
	};

	config = lib.mkIf config.user.enable {
		users.users."${config.user.username}" = {
			isNormalUser = true;
			extraGroups = lib.mkMerge [
				[
					"wheel"
				]
				(if config.system.virtualization.program == "virtualbox" then
					[
						"vboxsf"
					]
				else [])
			];
			initialPassword = "nixos";
		};
	};
}
