{ config, pkgs, lib, ... }:

{
	config = lib.mkIf config.desktop.enable {
		services.xserver.displayManager.startx.enable = true;
		services.greetd = {
			enable = true;
			settings = {
				default_session = {
					command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -w 60 -r --container-padding 2 --theme border=gray;text=gray;prompt=gray;time=white;action=gray;button=gray;container=black;input=white --cmd startx";
					user = "greeter";
				};
			};
		};
	};
}
