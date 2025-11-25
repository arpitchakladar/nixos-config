{ config, lib, ... }:

{
	options.system.boot = {
		enable = lib.mkEnableOption "Enables boot configuration.";
		device = lib.mkOption {
			type = lib.types.str;
			description = "Which device to boot from.";
		};
		efi = lib.mkOption {
			type = lib.types.bool;
			description = "Enables efi mode.";
		};
	};

	config = lib.mkIf config.system.boot.enable
	(let
		ifEfi = value: lib.mkIf config.system.boot.efi value;
	in {
		boot.loader.grub.enable = false;
		boot.loader.efi.efiSysMountPoint = ifEfi "/boot";
		boot.loader.systemd-boot.enable = true;
		boot.loader.efi.canTouchEfiVariables = ifEfi true;
	});
}
