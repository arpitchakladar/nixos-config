{ lib, config, ... }:

{
	options.system.networking = {
		enable = lib.mkEnableOption "Enable networking configuration.";
		host = lib.mkOption {
			type = lib.types.str;
			description = "Set the hostname for the machine.";
		};
	};

	config = lib.mkIf config.system.networking.enable {
		networking.hostName = config.system.networking.host;
		networking.networkmanager.enable = true;
	};
}
