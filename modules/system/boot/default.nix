{ config, lib, pkgs, ... }:

{
	imports = [
		./theme
	];

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
		# Use the GRUB 2 boot loader.
		boot.loader.grub.enable = true;
		# Define on which hard drive you want to install Grub.
		boot.loader.grub.device = config.system.boot.device; # or "nodev" for efi only
		boot.plymouth.enable = false;
		boot.loader.grub.splashImage = null;

		# EFI configs
		boot.loader.grub.efiSupport = ifEfi true;
		boot.loader.grub.efiInstallAsRemovable = ifEfi true;
		boot.loader.efi.efiSysMountPoint = ifEfi "/boot/efi";
	});
}
