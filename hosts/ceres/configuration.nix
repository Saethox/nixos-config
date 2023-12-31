# system configuration file of 'ceres' (replaces /etc/nixos/configuration.nix).
{
  inputs,
  lib,
  ...
}: {
  imports = [
    ../../nixos
    ../../nixos/desktop/plasma # Plasma Desktop
    ../../nixos/virtualization.nix # Virtualization (docker, etc.)

    # nixos-hardware settings for Lenovo Thinkpad X1 Carbon Gen 11.
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-11th-gen

    # Import the generated (nixos-generate-config) hardware configuration.
    ./hardware-configuration.nix

    # Enable fingerprint reader.
    ./fprint.nix
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
    openssh.authorizedKeys.keys = [];
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "docker"
    ];
  };

  # Overwrite number of jobs used for building with number of threads.
  nix.settings.max-jobs = lib.mkForce 12;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
