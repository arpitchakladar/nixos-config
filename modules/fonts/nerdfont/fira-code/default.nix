{ lib, config, pkgs, ... }:

{
	config = {
		environment.systemPackages = with pkgs; [
			nerd-fonts.fira-code
		];
	};
}
