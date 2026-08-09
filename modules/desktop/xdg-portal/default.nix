# XDG Desktop Portal - Desktop integration portal (file picker, screen capture)
{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./assertions.nix ];

  options.desktop.xdgPortal = {
    enable = lib.mkEnableOption "XDG desktop portals";
  };

  config = lib.mkIf config.desktop.xdgPortal.enable {
    xdg.portal = {
      enable = true;
    };
  };
}
