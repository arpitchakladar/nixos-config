{ config, lib, pkgs, ... }:

{
	imports = [
		./sddm
	];

	options.graphical = {
		enable = lib.mkEnableOption "Enable graphical interface.";
	};

	config = lib.mkIf config.graphical.enable {
		services.xserver.enable = true;
		services.xserver.windowManager.bspwm.enable = true;
		services.xserver.libinput.enable = true;
	};
}
