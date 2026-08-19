# Ly - TUI login manager
{ config, lib, ... }:
{
  config = lib.mkIf config.desktop.enable {
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
