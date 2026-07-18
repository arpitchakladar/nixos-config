# Fonts - System font packages (Fira Code Nerd Font)
{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };
}
