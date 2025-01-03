{ lib, config, pkgs, ... }:

{
	imports = [
		./ly
		./sddm
	];

	options.display-server = {
		enable = lib.mkEnableOption "Enable display server configuration.";
	};

	config = lib.mkIf config.display-server.enable {
		services.xserver.enable = true;

		services.displayManager.defaultSession = "xinit";

		environment.systemPackages = with pkgs.xorg; [
			libX11
			libXext
			libXrandr
			libXrender
			libXtst
			libXinerama
		];

		services.xserver.displayManager.session = [
			{
				manage = "desktop";
				name = "xinit";
				start = "exec $HOME/.xinitrc";
			}
		];

		services.xserver.displayManager.startx.enable = true;
	};
}
