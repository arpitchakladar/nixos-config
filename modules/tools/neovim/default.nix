# Neovim - Modern Vim-based text editor
{ config, lib, ... }:
{
  options.tools.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf config.tools.neovim.enable {
    programs.neovim.enable = true;
  };
}
