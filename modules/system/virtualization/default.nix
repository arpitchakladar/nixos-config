{ lib, config, ... }:

# Configuration for if the machine is running on a virtual machine
{
	imports = [
		./virtualbox
		./vmware
	];

	options.system.virtualization = {
		enable = lib.mkEnableOption "Enable virtualization guest capabilities.";
		program = lib.mkOption {
			type = lib.types.enum [
				"virtualbox"
				"vmware"
			];
			description = "The program that is being used for virtualization.";
		};
		audio.legacyIntel = lib.mkEnableOption "Use legacy Intel autio chipset.";
		sharedFolders = lib.mkOption {
			type = lib.types.listOf (lib.types.submodule {
				options = {
					directory = lib.mkOption {
						type = lib.types.str;
						description = "Path to the shared folder on this guest machine.";
					};

					device = lib.mkOption {
						type = lib.types.str;
						description = "Device name for the shared folder.";
					};
				};
			});
			default = [];
			description = "List of shared folders for the VM.";
		};
	};
}
