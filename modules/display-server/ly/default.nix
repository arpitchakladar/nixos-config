{ lib, config, pkgs, ... }:

{
	options.display-server.ly = {
		enable = lib.mkEnableOption "Enable ly display manager.";
	};

	# Define SDDM theme files
	config = lib.mkIf config.display-server.ly.enable {
		services.xserver.autorun = false;
		services.displayManager.ly.enable = true;
	};
}
