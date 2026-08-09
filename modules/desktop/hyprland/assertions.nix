{ config, ... }:
{
  assertions = [
    {
      assertion = !config.desktop.hyprland.enable || config.desktop.libinput.enable;
      message = ''
        desktop.hyprland.enable requires desktop.libinput.enable.
        Hyprland needs libinput for desktop input devices; enable desktop.libinput
        in the same host configuration.
      '';
    }
    {
      assertion = !config.desktop.hyprland.enable || config.desktop.dconf.enable;
      message = ''
        desktop.hyprland.enable requires desktop.dconf.enable.
        Enable dconf to provide the standard desktop settings database expected by
        graphical applications in this Hyprland session.
      '';
    }
  ];
}
