{ config, lib, pkgs, ... }:

{
	config = lib.mkIf
		(
			config.system.virtualization.enable
			&& config.system.virtualization.program == "vmware"
	) {
		virtualisation.vmware.guest.enable = true;
		boot.kernelModules = [ "vmhgfs" ];
		services.xserver.videoDrivers = lib.mkIf config.graphical.enable [ "vmware" ];
		systemd.tmpfiles.rules = [
			"d /mnt/vmware 0755 root root -"
		];
		fileSystems."/mnt/vmware" = {
			device = ".host:/";
			fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
			options = [
				"umask=22"
				"uid=1000"
				"gid=1000"
				"defaults"
				"allow_other"
				"auto_unmount"
				"nofail"
			];
		};
	};
}
