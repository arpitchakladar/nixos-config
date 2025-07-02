{ lib, config, ... }:

{
	options.system.networking = {
		enable = lib.mkEnableOption "Enable networking configuration.";

		host = lib.mkOption {
			type = lib.types.str;
			description = "Set the hostname for the machine.";
		};

		allowedTCPPorts = lib.mkOption {
			type = lib.types.listOf lib.types.int;
			default = lib.range 8000 8100;
			description = "List of TCP ports allowed through the firewall.";
		};
	};

	config = lib.mkIf config.system.networking.enable {
		networking.hostName = config.system.networking.host;
		networking.networkmanager.enable = true;
		networking.firewall.allowedTCPPorts = config.system.networking.allowedTCPPorts;
	};
}
