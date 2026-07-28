{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.desktop.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
