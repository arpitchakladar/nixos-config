{ config, lib, ... }:

{
	config = lib.mkIf (config.system.virtualization.enable && config.system.virtualization.program == "virtualbox") {
		virtualisation.virtualbox.guest.enable = true;
		fileSystems."${config.system.virtualization.sharedFolder.directory}" = {
			fsType = "vboxsf";
			device = config.system.virtualization.sharedFolder.device;
			options = [ "rw" "nofail" ];
		};
		services.xserver.videoDrivers = lib.mkForce [ "vmware" "virtualbox" "modesetting" ];
		systemd.services.virtualbox-resize = {
			description = "VirtualBox Guest Screen Resizing";

			wantedBy = [ "multi-user.target" ];
			requires = [ "dev-vboxguest.device" ];
			after = [ "dev-vboxguest.device" ];

			unitConfig.ConditionVirtualization = "oracle";

			serviceConfig.ExecStart = "@${config.boot.kernelPackages.virtualboxGuestAdditions}/bin/VBoxClient --vmsvga";
		};
	};
}
