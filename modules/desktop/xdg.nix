{ config, pkgs, lib, ... }:

{
	config = lib.mkIf config.desktop.enable {
		xdg.portal = {
			enable = true;
			extraPortals = with pkgs; [
				xdg-desktop-portal-gtk
			];
			config = {
				common = {
					default = [ "gtk" ];
				};
			};
		};

		environment.variables = {
			GTK_USE_PORTAL = "1";
		};
	};
}
