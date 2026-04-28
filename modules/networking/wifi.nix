{
  pkgs,
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
        };
        Network = {
          EnableIPv6 = true;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      iw
    ];

    # service to disable wifi powersafe (causes more issues than fixes sometimes)
    systemd.services.disable-wifi-powersave = {
      description = "Disable Wi-Fi Power Saving";

      # Run after the network hardware is initialized
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.iw}/bin/iw dev $(${pkgs.iw}/bin/iw dev | grep Interface | cut -f 2 -s -d \" \") set power_save off'";
        RemainAfterExit = true;
      };
    };
  };
}
