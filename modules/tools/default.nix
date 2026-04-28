{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash
    neovim
    git
    xclip
  ];
}
