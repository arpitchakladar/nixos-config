# WiFi - Wireless networking via systemd-networkd and iwd
{
  lib,
  config,
  ...
}:
{
  imports = [ ./assertions.nix ];

  options.networking.wifi = {
    enable = lib.mkEnableOption "Enable wifi via systemd-networkd + iwd";
  };

  config = lib.mkIf config.networking.wifi.enable {
    networking.wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = false;
          RoamThreshold = -120;
        };
        Network = {
          EnableIPv6 = true;
        };
        Scan = {
          DisableRoamingScan = true;
          DisablePeriodicScan = true;
        };
        DriverQuirks = {
          PowerSaveDisable = "*";
        };
      };
    };
  };
}
