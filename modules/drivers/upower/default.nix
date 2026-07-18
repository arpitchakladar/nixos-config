# UPower - Power management daemon (battery, sleep)
{ config, lib, ... }:
{
  options.drivers.upower = {
    enable = lib.mkEnableOption "Enable upower.";
  };

  config = lib.mkIf config.drivers.upower.enable {
    services.upower.enable = true;
  };
}
