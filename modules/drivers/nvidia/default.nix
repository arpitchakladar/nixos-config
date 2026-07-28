# NVIDIA - NVIDIA GPU drivers with PRIME Offloading
{
  config,
  pkgs,
  lib,
  ...
}:
# Nvidia gpu graphics with PRIME Offloading
let
  cfg = config.drivers.nvidia;

  # Converts a bus ID to the sysfs/udev "KERNELS" form, e.g.
  #   "PCI:5:0:0"        "0000:05:00.0"
  #   "0000:05:00.0"     "0000:05:00.0"  (passed through unchanged)
  toSysfsBusId =
    busId:
    let
      parts = lib.splitString ":" busId;
    in
    if lib.length parts == 4 && builtins.elemAt parts 0 == "PCI" then
      let
        bus = lib.fixedWidthString 2 "0" (builtins.elemAt parts 1);
        dev = lib.fixedWidthString 2 "0" (builtins.elemAt parts 2);
        func = builtins.elemAt parts 3;
      in
      "0000:${bus}:${dev}.${func}"
    else
      busId;

  mkGpuSymlinkRule =
    name: busId:
    lib.optionalString (busId != "") ''
      KERNEL=="card*", KERNELS=="${toSysfsBusId busId}", SUBSYSTEM=="drm", SYMLINK+="dri/gpu-${name}"
    '';
in
{
  options.drivers.nvidia = {
    enable = lib.mkEnableOption "Enable nvidia drivers.";
    amdgpuBusId = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "PCI Bus ID for AMD GPU.";
    };
    intelBusId = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "PCI Bus ID for Intel GPU.";
    };
    nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      description = "PCI Bus ID for NVIDIA GPU.";
    };
  };
  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [
      (
        if cfg.intelBusId != "" then
          "modesetting"
        else if cfg.amdgpuBusId != "" then
          "amdgpu"
        else
          null
      )
      "nvidia"
    ];
    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      dynamicBoost.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = lib.mkIf (cfg.amdgpuBusId != "") cfg.amdgpuBusId;
        intelBusId = lib.mkIf (cfg.intelBusId != "") cfg.intelBusId;
        nvidiaBusId = cfg.nvidiaBusId;
      };
    };

    # Stable, colon-free /dev/dri symlinks for use with tools like
    # Hyprland's AQ_DRM_DEVICES, which splits its value on ":" and
    # therefore breaks on /dev/dri/by-path/pci-... device nodes.
    services.udev.extraRules = lib.concatStrings [
      (mkGpuSymlinkRule "nvidia" cfg.nvidiaBusId)
      (mkGpuSymlinkRule "amd" cfg.amdgpuBusId)
      (mkGpuSymlinkRule "intel" cfg.intelBusId)
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vulkan-loader
        vulkan-tools
        freetype
        libXfont2
        libXrandr
        gamemode.lib
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-loader
        vulkan-tools
        freetype
        libXfont2
        libXrandr
        gamemode.lib
      ];
    };
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
      };
    };
  };
}
