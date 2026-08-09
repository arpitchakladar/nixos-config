# Libvirt - VM and container support
{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.virtualization.libvirt = {
    enable = lib.mkEnableOption "libvirtd, QEMU/KVM, and SPICE USB redirection";
    kvmModule = lib.mkOption {
      type = lib.types.enum [
        "kvm-amd"
        "kvm-intel"
      ];
      description = "Kernel KVM module appropriate for this host CPU.";
    };
  };

  config = lib.mkIf config.virtualization.libvirt.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        runAsRoot = false;
      };
    };

    virtualisation.spiceUSBRedirection.enable = true;
    boot.kernelModules = [ config.virtualization.libvirt.kvmModule ];
  };
}
