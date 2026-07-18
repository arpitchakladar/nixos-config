# Bertor - Host-specific system configuration
{ ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  baseDirectory = "/etc/nixos";

  audio.enable = true;

  networking.enable = true;
  networking.host = "bertor";
  networking.bluetooth.enable = true;
  networking.wifi.enable = true;

  time.timeZone = "Asia/Kolkata";

  powerManagement.enable = true;

  tools.zsh.enable = true;
  tools.neovim.enable = true;
  tools.git.enable = true;
  tools.xclip.enable = true;

  drivers.upower.enable = true;

  desktop.enable = true;

  drivers.nvidia.enable = true;
  drivers.nvidia.amdgpuBusId = "PCI:5:0:0";
  drivers.nvidia.nvidiaBusId = "PCI:1:0:0";

  user.users = [
    {
      username = "arpit";
      wheel = true;
    }
  ];

  virtualization.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
