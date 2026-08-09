{ config, ... }:
{
  assertions = [
    {
      assertion = !config.desktop.xdgPortal.enable || config.desktop.dconf.enable;
      message = ''
        desktop.xdgPortal.enable requires desktop.dconf.enable.
        XDG portals are desktop-session integration services; enable dconf to provide
        the standard settings backend used by desktop applications.
      '';
    }
  ];
}
