{ lib, config, ... }:

{
  imports = [
    ./bluetooth.nix
    ./wifi.nix
  ];

  options.networking = {
    enable = lib.mkEnableOption "Enable networking configuration.";

    host = lib.mkOption {
      type = lib.types.str;
      description = "Set the hostname for the machine.";
    };
  };

  config = lib.mkIf config.networking.enable {
    networking.hostName = config.networking.host;
    networking.useNetworkd = true;
    systemd.network.enable = true;
    networking.firewall.enable = true;

    # critical — lets networkd manage DNS
    services.resolved.enable = true;
    networking.nameservers = [ ];
  };
}
