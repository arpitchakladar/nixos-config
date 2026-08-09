# Dconf - Desktop settings database
{ config, lib, ... }:
{
  options.desktop.dconf = {
    enable = lib.mkEnableOption "the dconf desktop settings database";
  };

  config = lib.mkIf config.desktop.dconf.enable {
    programs.dconf.enable = true;
  };
}
