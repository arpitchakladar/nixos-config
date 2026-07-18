# Boot - Bootloader configuration (systemd-boot)
{ ... }:
{
  config = {
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };
  };
}
