{ config, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };
  
  services.jellyfin = {
    enable = true;
    hardwareAcceleration = true;
    environmentVariables = {
      # Enable NVENC/NVDEC
      LIBVA_DRIVER_NAME = "nvidia";
      NVIDIA_DRIVER_CAPABILITIES = "compute,video,utility";
    };
  };
}
