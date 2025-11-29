{ lib, config, pkgs, ... }:

{
	options.networking.bluetooth = {
		enable = lib.mkEnableOption "Enable bluetooth.";
	};

	config = lib.mkIf config.networking.bluetooth.enable {
		hardware.bluetooth.enable = true;
	};
}
