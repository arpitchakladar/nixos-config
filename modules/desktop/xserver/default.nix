# X Server - X11 display server and window manager (bspwm)
{ config, lib, ... }:
{
  config = lib.mkIf config.desktop.enable {
    services.xserver = {
      enable = true;
      windowManager.bspwm.enable = true;
      # Enabled by default, don't need it
      desktopManager.xterm.enable = false;
      displayManager.startx.enable = true;
    };
  };
}
