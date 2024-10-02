{ lib, config, ... }:

{
	options.display-server = {
		enable = lib.mkEnableOption "Enable display server configuration.";
	};

	config = lib.mkIf config.display-server.enable {
		services.xserver.enable = true;
		services.xserver.autorun = false;
		services.displayManager.ly.enable = true;
		services.xserver.displayManager.startx.enable = true;
	};
}
