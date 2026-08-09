# PipeWire - Sound server configuration
{ config, lib, ... }:
{
  options.audio.pipewire = {
    enable = lib.mkEnableOption "PipeWire audio with PulseAudio compatibility and WirePlumber.";
  };

  config = lib.mkIf config.audio.pipewire.enable {
    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
