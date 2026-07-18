# Zsh - Z shell
{ config, lib, ... }:
{
  options.tools.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf config.tools.zsh.enable {
    programs.zsh.enable = true;
  };
}
