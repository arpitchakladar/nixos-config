{ config, lib, ... }:

{
  config = lib.mkIf config.desktop.enable {
    services.xserver = {
      enable = true;
      windowManager.bspwm.enable = true;
      desktopManager.xterm.enable = false;
    };
  };
}
