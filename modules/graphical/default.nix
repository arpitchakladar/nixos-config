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
		environment.systemPackages = with pkgs; [
			xorg.xinit
		];
		services.xserver.displayManager.session = [{
			manage = "window";
			name = "xinit";
			start = "waitPID=$!";
		}];
	};
}
