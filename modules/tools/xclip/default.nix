{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.tools.xclip = {
    enable = lib.mkEnableOption "xclip";
  };

  config = lib.mkIf config.tools.xclip.enable {
    environment.systemPackages = with pkgs; [ xclip ];
  };
}
