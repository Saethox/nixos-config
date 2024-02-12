# system configuration file of 'ceres' (replaces /etc/nixos/configuration.nix).
{
  inputs,
  lib,
  ...
}: {
  imports = [
    # Global system configuration.
    ../../nixos

    ../../nixos/desktop/x11 # X11 Windowing System
    ../../nixos/desktop/x11/plasma # Plasma Desktop
    ../../nixos/desktop/x11/touchpad.nix # Touchpad + Gestures
    ../../nixos/mounts/uni.nix # Uni drives

    # Input modules.
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-11th-gen # nixos-hardware settings for Lenovo Thinkpad X1 Carbon Gen 11.

    # Device-specific configuration.
    ./hardware # Auto-generated (nixos-generate-config) hardware configuration.
    ./desktop/x11/autorandr # Monitor profiles
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set the hostname.
  networking.hostName = "ceres";

  # Enable networking.
  networking.networkmanager.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Power management.
  services.auto-cpufreq.enable = true;
  services.thermald.enable = true;

  # Configure system-wide user settings (groups, etc), add more users as needed.
  users.users.wurthjon = {
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
  nix.settings.max-jobs = lib.mkForce 12;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
