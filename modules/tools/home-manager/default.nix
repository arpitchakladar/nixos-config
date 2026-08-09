# Home Manager CLI - Standalone home-manager executable
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.tools.homeManager = {
    enable = lib.mkEnableOption "the standalone home-manager command-line executable";
  };

  config = lib.mkIf config.tools.homeManager.enable {
    environment.systemPackages = [ pkgs.home-manager ];
  };
}
