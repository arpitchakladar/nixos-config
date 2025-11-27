
{ lib, config, ... }:

{
	imports = [
		./bluetooth.nix
	];

	options.networking = {
		enable = lib.mkEnableOption "Enable networking configuration.";

		host = lib.mkOption {
			type = lib.types.str;
			description = "Set the hostname for the machine.";
		};

		allowedTCPPorts = lib.mkOption {
			type = lib.types.listOf lib.types.int;
			default = [];
			description = "List of TCP ports allowed through the firewall.";
		};
	};

	config = lib.mkIf config.networking.enable {
		networking.hostName = config.networking.host;
		networking.networkmanager.enable = true;
		networking.firewall.enable = true;
		networking.firewall.allowedTCPPorts = config.networking.allowedTCPPorts;
	};
}
