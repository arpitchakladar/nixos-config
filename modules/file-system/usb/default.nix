# USB
{
  lib,
  config,
  ...
}:
{
  options.fileSystem.usb = {
    enable = lib.mkEnableOption "Enable usb via systemd-networkd + iwd";
  };

  config = lib.mkIf config.fileSystem.usb.enable {
    services.udisks2.enable = true;
    services.gvfs.enable = true;
  };
}
