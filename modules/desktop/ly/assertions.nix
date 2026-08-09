{ config, ... }:
{
  assertions = [
    {
      assertion = !config.desktop.ly.enable || config.desktop.hyprland.enable;
      message = ''
        desktop.ly.enable requires desktop.hyprland.enable in this configuration.
        Ly is the display-manager entry point for the configured graphical session;
        enable Hyprland or replace this module with a display manager for another session.
      '';
    }
  ];
}
