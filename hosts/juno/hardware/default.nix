{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    # nixos-hardware settings for Lenovo ThinkBook 16p Gen 2.
    inputs.hardware.nixosModules.common-cpu-amd-pstate
    # inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-laptop-ssd
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking.
  networking.networkmanager.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Enable fingerprint.
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      # This driver seems to be correct.
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  # Enable laptop settings.
  modules.hardware.laptop.enable = true;
}
