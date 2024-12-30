{ lib, ... }:

{
	imports = [
		./display-server
		./user
		./system
		./tools
	];

	options = {
		baseDirectory = lib.mkOption {
			type = lib.types.str;
			description = "Path to the base of the nixos configuration.";
			default = "/etc/nixos";
		};
	};
}
