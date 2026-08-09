# GVFS - Desktop virtual filesystem support
{ config, lib, ... }:
{
  options.fileSystem.gvfs = {
    enable = lib.mkEnableOption "GVFS desktop filesystem integration";
  };

  config = lib.mkIf config.fileSystem.gvfs.enable {
    services.gvfs.enable = true;
  };
}
