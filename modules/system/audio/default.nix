{ config, lib, ... }:

{
	options.system.audio = {
		enable = lib.mkEnableOption "Enable audio configuration.";
	};

	config = lib.mkIf config.system.audio.enable {
		services.pipewire = {
			enable = true;
			audio.enable = true;
			pulse.enable = true;
			wireplumber.enable = true;
		};
	};
}
