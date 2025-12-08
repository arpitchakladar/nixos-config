{ lib, config, pkgs, ... }:

{
	options.virtualization = {
		enable = lib.mkEnableOption "Enable virtualization.";
	};

	config = lib.mkIf config.virtualization.enable {
		virtualisation.libvirtd = {
			enable = true;
			qemu = {
				swtpm.enable = true;
				runAsRoot = true;
			};
		};
		programs.virt-manager.enable = true;
	};
}
