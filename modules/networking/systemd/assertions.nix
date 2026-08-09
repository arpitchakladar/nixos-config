{ config, lib, ... }:
{
  assertions = [
    {
      assertion = !config.networking.systemd.enable || config.networking.systemd.hostName != "";
      message = ''
        networking.systemd.enable is true, but networking.systemd.hostName is empty.
        The core networking module manages the system hostname, so every enabled host
        must provide a non-empty hostname (for example, "workstation") in its host file.
      '';
    }
  ];
}
