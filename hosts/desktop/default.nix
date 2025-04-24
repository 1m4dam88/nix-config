{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  # Kernel and boot configuration
  boot = {
    kernelModules = [ "kvm-amd" "amdgpu" ];
    kernelParams = [ 
      "amd_iommu=on" 
      "iommu=pt" 
      "pcie_aspm=off" # Better PCIe performance
      "mitigations=off" # For maximum performance
    ];
    initrd.kernelModules = [ "amdgpu" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1; # Faster boot
    };
  };

  # AMD hardware configuration
  hardware = {
    cpu.amd.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };

    # Enable AMD GPU monitoring and control
    radeon.settings = {
      "ppfeaturemask" = "0xffffffff";
      "power_dpm_force_performance_level" = "high";
    };
  };

  # Performance tuning
  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  # CPU performance tuning
  environment.variables = {
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";
    AMD_VULKAN_ICD = "RADV";
  };

  # Overclocking/undervolting support
  boot.extraModprobeConfig = ''
    options amdgpu ppfeaturemask=0xffffffff
    options amdgpu overdrive=1
  '';

  system.stateVersion = "24.11";
}
