{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.virtualization = {
    enable = lib.mkEnableOption "Enable virtualization.";
  };

  config = lib.mkIf config.virtualization.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        runAsRoot = false;
      };
    };

    # NOTE: Change this depending on your cpu architecture
    boot.kernelModules = [ "kvm-amd" ];
  };
}
