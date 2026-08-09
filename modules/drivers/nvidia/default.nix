# NVIDIA - Reusable NVIDIA and PRIME graphics configuration
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drivers.nvidia;

  toSysfsBusId =
    busId:
    let
      parts = lib.splitString ":" busId;
    in
    if lib.length parts == 4 && builtins.elemAt parts 0 == "PCI" then
      let
        bus = lib.fixedWidthString 2 "0" (builtins.elemAt parts 1);
        device = lib.fixedWidthString 2 "0" (builtins.elemAt parts 2);
        function = builtins.elemAt parts 3;
      in
      "0000:${bus}:${device}.${function}"
    else
      busId;

  mkGpuSymlinkRule =
    name: busId:
    lib.optionalString (busId != null) ''
      KERNEL=="card*", KERNELS=="${toSysfsBusId busId}", SUBSYSTEM=="drm", SYMLINK+="dri/gpu-${name}"
    '';

  integratedDriver =
    ({
      amd = "amdgpu";
      intel = "modesetting";
    }).${cfg.integratedGpu} or null;
in
{
  imports = [ ./assertions.nix ];

  options.drivers.nvidia = {
    enable = lib.mkEnableOption "the NVIDIA graphics driver stack";
    mode = lib.mkOption {
      type = lib.types.enum [
        "standalone"
        "offload"
        "sync"
      ];
      default = "standalone";
      description = ''
        GPU topology: "standalone" for an NVIDIA-only desktop, "offload" for an
        integrated GPU driving displays with NVIDIA used on demand, or "sync" for
        a PRIME laptop where NVIDIA drives the display through the integrated GPU.
      '';
    };
    integratedGpu = lib.mkOption {
      type = lib.types.enum [
        "none"
        "amd"
        "intel"
      ];
      default = "none";
      description = "Integrated GPU vendor used by PRIME modes; use none for standalone NVIDIA.";
    };
    integratedGpuBusId = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "PCI bus ID of the AMD or Intel integrated GPU, for example PCI:5:0:0.";
    };
    nvidiaBusId = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "PCI bus ID of the NVIDIA GPU, for example PCI:1:0:0.";
    };
    open = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use NVIDIA's open kernel modules; appropriate for recent GPUs such as RTX 5060.";
    };
    enable32Bit = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Install 32-bit graphics support for Steam, Wine, and older games.";
    };
    gaming.enable = lib.mkEnableOption "GameMode and the Vulkan utilities";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = lib.optionals (cfg.mode != "standalone") [ integratedDriver ] ++ [
      "nvidia"
    ];

    hardware.nvidia = {
      open = cfg.open;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = cfg.mode == "offload";
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      prime = lib.mkIf (cfg.mode != "standalone") {
        offload = lib.mkIf (cfg.mode == "offload") {
          enable = true;
          enableOffloadCmd = true;
        };
        sync.enable = cfg.mode == "sync";
        amdgpuBusId = lib.mkIf (cfg.integratedGpu == "amd") cfg.integratedGpuBusId;
        intelBusId = lib.mkIf (cfg.integratedGpu == "intel") cfg.integratedGpuBusId;
        inherit (cfg) nvidiaBusId;
      };
    };

    services.udev.extraRules = lib.concatStrings [
      (mkGpuSymlinkRule "nvidia" cfg.nvidiaBusId)
      (lib.optionalString (cfg.integratedGpu == "amd") (mkGpuSymlinkRule "amd" cfg.integratedGpuBusId))
      (lib.optionalString (cfg.integratedGpu == "intel") (
        mkGpuSymlinkRule "intel" cfg.integratedGpuBusId
      ))
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = cfg.enable32Bit;
      extraPackages =
        with pkgs;
        [
          vulkan-loader
          vulkan-tools
          freetype
          libXfont2
          libXrandr
        ]
        ++ lib.optionals cfg.gaming.enable [ gamemode.lib ];
      extraPackages32 =
        with pkgs.pkgsi686Linux;
        [
          vulkan-loader
          vulkan-tools
          freetype
          libXfont2
          libXrandr
        ]
        ++ lib.optionals cfg.gaming.enable [ gamemode.lib ];
    };

    programs.gamemode = lib.mkIf cfg.gaming.enable {
      enable = true;
      enableRenice = true;
      settings.general = {
        softrealtime = "auto";
        renice = 10;
      };
    };
  };
}
