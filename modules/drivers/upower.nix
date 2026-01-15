{ config, pkgs, lib, ... }:

{
	config = {
		services.upower.enable = true;
	};
}
