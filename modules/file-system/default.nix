# File system - Filesystem configuration (NTFS, exFAT, USB)
{
  lib,
  config,
  ...
}:
{
  imports = [
    ./usb
  ];

  options.fileSystem = {
    enable = lib.mkEnableOption "Enable file system configuration.";
  };

  config = lib.mkIf config.fileSystem.enable {
    boot.supportedFilesystems = [
      "ntfs"
      "exfat"
    ];
  };
}
