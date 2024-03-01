# system configuration file of 'juno' (replaces /etc/nixos/configuration.nix).
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Global system configuration.
    ../../nixos

    # Input modules.

    # nixos-hardware settings for Lenovo ThinkBook 16p Gen 2.
    inputs.hardware.nixosModules.common-cpu-amd-pstate
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    # Device-specific configuration.
    ./hardware # Auto-generated (nixos-generate-config) hardware configuration.
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set the hostname.
  networking.hostName = "juno";

  # Enable networking.
  networking.networkmanager.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Configure system-wide user settings (groups, etc), add more users as needed.
  users.users.joni = {
    isNormalUser = true;
    description = "Jonathan Wurth";
    uid = 1000;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "docker"
      "input"
    ];
  };

  # Overwrite number of jobs used for building with number of threads.
  nix.settings.max-jobs = lib.mkForce 16;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
