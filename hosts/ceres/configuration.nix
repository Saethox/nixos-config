# system configuration file of 'ceres' (replaces /etc/nixos/configuration.nix).
{lib, ...}: {
  imports = [
    ../../nixos
    ./hardware
  ];

  # Set the hostname.
  networking.hostName = "ceres";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable desktop environments.
  modules.desktop.plasma6.enable = true;

  # Enable uni samba drive mounts.
  modules.mounts.uni.enable = true;

  # Enable mullvad.
  modules.services.mullvad.enable = true;

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

  # Add as trusted user of the Nix store.
  nix.settings.trusted-users = ["root" "wurthjon"];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
