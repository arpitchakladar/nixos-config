# Desktop - Desktop feature modules
{ lib, ... }:
{
  imports = [
    ./ly
    ./xdg-portal
    ./hyprland
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enables the desktop features";
  };
}
