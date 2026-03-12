{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    git
    xclip
  ];

  programs.zsh.enable = true;
}
