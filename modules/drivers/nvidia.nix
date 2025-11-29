{ config, pkgs, lib, ... }:

{
	options.drivers.nvidia = {
		enable = lib.mkEnableOption "Enable nvidia drivers.";
	};

	config = lib.mkIf config.drivers.nvidia.enable {
		services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

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
				amdgpuBusId = "PCI:5:0:0";
				nvidiaBusId = "PCI:1:0:0";
			};
		};

		hardware.graphics = {
			enable = true;
			extraPackages = with pkgs; [ vulkan-loader ];
			extraPackages32 = with pkgs; [ vulkan-loader_32bit ];
		};
	};
}
