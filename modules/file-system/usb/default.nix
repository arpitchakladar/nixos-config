# USB storage - Removable-drive mounting via UDisks2
{
  lib,
  config,
  ...
}:
{
  options.fileSystem.usb = {
    enable = lib.mkEnableOption "removable USB-drive mounting through UDisks2";
  };

  config = lib.mkIf config.fileSystem.usb.enable {
    services.udisks2.enable = true;
  };
}
