{ config, lib, pkgs, inputs, ... }:

{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	baseDirectory = "/etc/nixos";

	audio.enable = true;

	networking.enable = true;
	networking.host = "bertor";
	networking.bluetooth.enable = true;
	networking.wifi.enable = true;

	time.timeZone = "Asia/Kolkata";

	powerManagement.enable = true;

	desktop.enable = true;

	drivers.nvidia.enable = true;
	drivers.nvidia.amdgpuBusId = "PCI:5:0:0";
	drivers.nvidia.nvidiaBusId = "PCI:1:0:0";

	user.users = [
		{
			username = "arpit";
			wheel = true;
		}
	];

	virtualization.enable = true;

	nixpkgs.config.allowUnfree = true;

	system.stateVersion = "25.05";
}

