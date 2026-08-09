{ config, ... }:
{
  assertions = [
    {
      assertion = !config.networking.wifi.enable || config.networking.systemd.enable;
      message = ''
        networking.wifi.enable requires networking.systemd.enable.
        Wi-Fi is configured to coexist with systemd-networkd and systemd-resolved;
        enable networking.systemd on this host before enabling the Wi-Fi feature.
      '';
    }
  ];
}
