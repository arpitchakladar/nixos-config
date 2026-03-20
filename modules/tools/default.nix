{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim-unwrapped
    git
    xclip
  ];
}
