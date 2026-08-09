# Bertor - Host-specific system configuration
{ inputs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  baseDirectory = "/etc/nixos";

  audio.pipewire.enable = true;

  networking.systemd = {
    enable = true;
    hostName = "bertor";
  };
  networking.bluetooth.enable = true;
  networking.wifi.enable = true;

  fileSystem.support.enable = true;
  fileSystem.usb.enable = true;
  fileSystem.gvfs.enable = true;

  time.timeZone = "Asia/Kolkata";

  powerManagement.enable = true;

  tools.zsh.enable = true;
  tools.neovim.enable = true;
  tools.git.enable = true;
  tools.homeManager.enable = true;

  drivers.upower.enable = true;

  desktop.libinput.enable = true;
  desktop.dconf.enable = true;
  desktop.hyprland.enable = true;
  desktop.ly.enable = true;
  desktop.xdgPortal.enable = true;

  drivers.nvidia = {
    enable = true;
    mode = "offload";
    integratedGpu = "amd";
    integratedGpuBusId = "PCI:5:0:0";
    nvidiaBusId = "PCI:1:0:0";
    gaming.enable = true;
  };

  user.users = [
    {
      username = "arpit";
      wheel = true;
      isTrustedUser = true;
      groups = {
        libvirt.enable = true;
      };
    }
  ];

  virtualization.libvirt = {
    enable = true;
    kvmModule = "kvm-amd";
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
