{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim-unwrapped
    git
    xclip
  ];

  programs.zsh.enable = true;
}
