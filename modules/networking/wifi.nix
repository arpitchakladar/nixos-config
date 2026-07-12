{
  lib,
  config,
  ...
}:

{
  options.networking.wifi = {
    enable = lib.mkEnableOption "Enable wifi via systemd-networkd + iwd";
  };

  config = lib.mkIf config.networking.wifi.enable {
    networking.wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = false;
          RoamThreshold = -90;
        };
        Network = {
          EnableIPv6 = true;
        };
        DriverQuirks = {
          PowerSaveDisable = "*";
        };
      };
    };
  };
}
