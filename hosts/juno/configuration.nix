# system configuration file of 'juno' (replaces /etc/nixos/configuration.nix).
{lib, pkgs, ...}: {
  imports = [
    ../../nixos
    ./hardware
  ];

  # Set the hostname.
  networking.hostName = "juno";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable desktop environments.
  modules.desktop.gnome.enable = true;
  modules.desktop.hyprland.enable = true;

  # Enable mullvad.
  modules.services.mullvad.enable = true;

  # Enable steam.
  modules.programs.steam.enable = true;

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
