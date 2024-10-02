{ lib, config, ... }:

# Configuration for if the machine is running on a virtual machine
{
	imports = [
		./virtualbox
	];

	options.system.virtualization = {
		enable = lib.mkEnableOption "Enable virtualization capabilities.";
		program = lib.mkOption {
			type = lib.types.enum [
				"virtualbox"
			];
			description = "The program that is being used for virtualization.";
		};
		sharedFolder = {
			directory = lib.mkOption {
				type = lib.types.str;
				description = "The path to the shared folder on this machine.";
			};

			device = lib.mkOption {
				type = lib.types.str;
				description = "The device that represents the shared folder.";
			};
		};
	};
}
