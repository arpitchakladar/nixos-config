# Ly - TUI display manager
{ config, lib, ... }:
{
  imports = [ ./assertions.nix ];

  options.desktop.ly = {
    enable = lib.mkEnableOption "the Ly terminal display manager";
  };

  config = lib.mkIf config.desktop.ly.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "gameoflife";
        battery_id = "BAT1";
        bigclock = "en";
        bigclock_12hr = true;
        gameoflife_initial_density = 0.1;
      };
    };
  };
}
