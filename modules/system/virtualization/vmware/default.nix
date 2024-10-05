{ config, lib, ... }:

{
	config = lib.mkIf (config.system.virtualization.enable && config.system.virtualization.program == "vmware") {
		virtualisation.vmware.guest.enable = true;
	};
}
