# Git - Distributed version control system
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.tools.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf config.tools.git.enable {
    environment.systemPackages = with pkgs; [ git ];
  };
}
