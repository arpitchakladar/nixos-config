# Libinput - Shared input-device support
{ config, lib, ... }:
{
  options.desktop.libinput = {
    enable = lib.mkEnableOption "libinput input-device support";
  };

  config = lib.mkIf config.desktop.libinput.enable {
    services.libinput.enable = true;
  };
}
