# Filesystem support - NTFS and exFAT support
{ config, lib, ... }:
{
  options.fileSystem.support = {
    enable = lib.mkEnableOption "NTFS and exFAT filesystem support";
  };

  config = lib.mkIf config.fileSystem.support.enable {
    boot.supportedFilesystems = [
      "ntfs"
      "exfat"
    ];
  };
}
