{ config, lib, ... }:

{
	options.system.boot = {
		enable = lib.mkEnableOption "Enables boot configuration.";
	};

	config = lib.mkIf config.system.boot.enable {
		# Use the GRUB 2 boot loader.
		boot.loader.grub.enable = true;
		# boot.loader.grub.efiSupport = true;
		# boot.loader.grub.efiInstallAsRemovable = true;
		# boot.loader.efi.efiSysMountPoint = "/boot/efi";
		# Define on which hard drive you want to install Grub.
		boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
	};
}
