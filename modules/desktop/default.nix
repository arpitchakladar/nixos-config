# Desktop - Desktop environment configuration (display manager, X server, portal)
{ config, lib, ... }:
{
  imports = [
    ./ly
    ./xdg-portal
    ./xserver
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable desktop environment.";
  };

  config = lib.mkIf config.desktop.enable {
    services.libinput.enable = true;
    programs.dconf.enable = true;
  };
}
