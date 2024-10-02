{ config, lib, ... }:

{
	options.system.time = {
		enable = lib.mkEnableOption "Enable time configuration.";
		timeZone = lib.mkOption {
			type = lib.types.str;
			description = "Set the time zone.";
		};
	};

	config = lib.mkIf config.system.time.enable {
		time.timeZone = config.system.time.timeZone;
	};
}
