{ lib, config, ... }:

{
	options.networking.wifi = {
		enable = lib.mkEnableOption "Enable wifi.";
	};

	config = lib.mkIf config.networking.wifi.enable {
		networking.wireless.iwd = {
			enable = true;
			settings = {
				General = {
					EnableNetworkConfiguration = true;
				};
			};
		};
	};
}
