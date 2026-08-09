{ config, ... }:
let
  cfg = config.drivers.nvidia;
  primeEnabled = cfg.enable && cfg.mode != "standalone";
in
{
  assertions = [
    {
      assertion = !primeEnabled || cfg.integratedGpu != "none";
      message = ''
        drivers.nvidia.mode is "${cfg.mode}", but drivers.nvidia.integratedGpu is "none".
        PRIME offload and sync modes require an AMD or Intel integrated GPU; set
        integratedGpu and both PCI bus IDs, or use mode = "standalone" for NVIDIA-only systems.
      '';
    }
    {
      assertion = !primeEnabled || cfg.integratedGpuBusId != null;
      message = ''
        drivers.nvidia.mode is "${cfg.mode}", but drivers.nvidia.integratedGpuBusId is not set.
        PRIME needs the integrated GPU PCI address to route display ownership correctly.
        Set it to the lspci-derived value, such as "PCI:5:0:0", in this host file.
      '';
    }
    {
      assertion = !primeEnabled || cfg.nvidiaBusId != null;
      message = ''
        drivers.nvidia.mode is "${cfg.mode}", but drivers.nvidia.nvidiaBusId is not set.
        PRIME needs the NVIDIA PCI address; set it to the lspci-derived value,
        such as "PCI:1:0:0", in this host file.
      '';
    }
    {
      assertion = !(cfg.enable && cfg.mode == "standalone" && cfg.integratedGpu != "none");
      message = ''
        drivers.nvidia.mode is "standalone" while drivers.nvidia.integratedGpu is configured.
        Standalone mode deliberately does not configure PRIME. Use "offload" or "sync"
        when a second AMD or Intel GPU participates in the graphics setup.
      '';
    }
  ];
}
