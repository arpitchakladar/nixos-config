{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		neovim
		git
		dmenu
		xclip
	];
}
