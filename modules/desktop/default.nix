{ config, lib, pkgs, ... }:

{
	imports = [
		./greetd.nix
		./xdg.nix
	];

	options.desktop = {
		enable = lib.mkEnableOption "Enable desktop environment.";
	};

	config = lib.mkIf config.desktop.enable {
		services.xserver.enable = true;
		services.xserver.windowManager.bspwm.enable = true;
		services.libinput.enable = true;
	};
}
