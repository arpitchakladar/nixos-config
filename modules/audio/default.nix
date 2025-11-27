{ config, lib, ... }:

{
	options.audio = {
		enable = lib.mkEnableOption "Enable audio configuration.";
	};

	config = lib.mkIf config.audio.enable {
		services.pipewire = {
			enable = true;
			audio.enable = true;
			pulse.enable = true;
			wireplumber.enable = true;
		};
	};
}
