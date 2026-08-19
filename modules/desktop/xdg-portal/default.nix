# XDG Desktop Portal - Desktop integration portal (file picker, screen capture)
{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.desktop.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      config.common = {
        default = [ "hyprland" ];
      };
      xdgOpenUsePortal = true;
    };
  };
}
