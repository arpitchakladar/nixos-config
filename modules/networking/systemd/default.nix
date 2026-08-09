# Networking systemd - Hostname, firewall, networkd, and DNS
{ config, lib, ... }:
{
  imports = [ ./assertions.nix ];

  options.networking.systemd = {
    enable = lib.mkEnableOption "the shared networkd, firewall, and resolved configuration";
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "Hostname assigned to this machine when networking.systemd is enabled.";
    };
  };

  config = lib.mkIf config.networking.systemd.enable {
    networking.hostName = config.networking.systemd.hostName;
    networking.useNetworkd = true;
    systemd.network.enable = true;
    networking.firewall.enable = true;
    services.resolved.enable = true;
    networking.nameservers = [ ];
  };
}
