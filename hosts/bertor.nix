{ config, lib, pkgs, inputs, ... }:

{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	baseDirectory = "/etc/nixos";

	audio.enable = true;

	networking.enable = true;
	networking.host = "bertor";
	networking.bluetooth.enable = true;

	time.timeZone = "Asia/Kolkata";

	powerManagement.enable = true;

	desktop.enable = true;

	drivers.nvidia.enable = true;

	user.enable = true;
	user.users = [
		{
			username = "arpit";
			wheel = true;
		}
	];

	nixpkgs.config.allowUnfree = true;

	system.stateVersion = "25.05";
}

