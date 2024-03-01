# system configuration file of 'ceres' (replaces /etc/nixos/configuration.nix).
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../nixos
    ./hardware

    # nixos-hardware settings for Lenovo ThinkPad X1 Carbon Gen 11.
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-11th-gen

  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Set the hostname.
  networking.hostName = "ceres";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable X11 Plasma Desktop with touchpad gestures.
  modules.desktop.x11.plasma.enable = true;
  modules.desktop.x11.touchpad = true;

  # Enable uni samba drive mounts.
  modules.mounts.uni.enable = true; 

  # Enable laptop settings.
  modules.laptop.enable = true;

  # Enable sound.
  modules.sound.enable = true;

  # Enable virtualization.
  modules.virtualization.enable = true;

  # Enable flatpaks.
  modules.flatpak.enable = true;

  # Configure fonts.
  modules.fonts.enable = true;

  # Enable mullvad.
  modules.mullvad.enable = true;

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
