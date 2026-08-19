{
  config,
  lib,
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
