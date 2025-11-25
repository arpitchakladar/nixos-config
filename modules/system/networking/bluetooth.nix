{ lib, config, ... }:

{
	options.system.networking.bluetooth = {
		enable = lib.mkEnableOption "Enable bluetooth.";
	};

	config = lib.mkIf config.system.networking.bluetooth.enable {
		hardware.bluetooth.enable = true;
		services.blueman.enable = true;
	};
}
