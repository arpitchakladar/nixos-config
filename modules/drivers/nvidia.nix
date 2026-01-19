{ config, pkgs, lib, ... }:

# Nvidia gpu graphics with PRIME Offloading
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

	config = lib.mkIf config.drivers.nvidia.enable {
		services.xserver.videoDrivers = [
			(if config.drivers.nvidia.intelBusId != "" then "modesetting"
				else if config.drivers.nvidia.amdgpuBusId != "" then "amdgpu"
				else null)
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
				amdgpuBusId = lib.mkIf (config.drivers.nvidia.amdgpuBusId != "")
					config.drivers.nvidia.amdgpuBusId;
				intelBusId = lib.mkIf (config.drivers.nvidia.intelBusId != "")
					config.drivers.nvidia.intelBusId;
				nvidiaBusId = config.drivers.nvidia.nvidiaBusId;
			};
		};

		hardware.graphics = {
			enable = true;
			enable32Bit = true;
			extraPackages = with pkgs; [ vulkan-loader ];
			extraPackages32 = with pkgs.pkgsi686Linux; [
				vulkan-loader
				vulkan-tools
			];
		};
	};
}
