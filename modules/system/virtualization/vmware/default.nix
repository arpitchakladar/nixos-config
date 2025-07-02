{ config, lib, ... }:

{
	config = lib.mkIf (config.system.virtualization.enable && config.system.virtualization.program == "vmware") {

		# TODO: Complete the implementation for vitualbox
		virtualisation.vmware.guest.enable = true;
	};
}
