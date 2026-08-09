{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./assertions.nix ];

  options.desktop.hyprland = {
    enable = lib.mkEnableOption "the Hyprland Wayland compositor";
  };

  config = lib.mkIf config.desktop.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
