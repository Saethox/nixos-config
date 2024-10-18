# system configuration file of 'titan' (replaces /etc/nixos/configuration.nix).
{
  lib,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ../../nixos
    ./hardware
  ];

  # Set the hostname.
  networking.hostName = "titan";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Wayland Plasma6 Desktop.
  modules.desktop.plasma6.enable = true;

  # Enable mullvad.
  modules.services.mullvad.enable = true;

  # Enable steam.
  modules.programs.steam.enable = true;

  # Enable virt-manager.
  modules.programs.virt.enable = true;

  # Enable ssh server.
  modules.services.ssh.enable = true;

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
      "gamemode"
    ];
    openssh.authorizedKeys.keys = builtins.attrValues outputs.constants.pubkeys;
  };

  # Set console font.
  console = {
    earlySetup = true;
    font = "ter-114b";
    packages = with pkgs; [
      terminus_font
    ];
  };

  # Overwrite number of jobs used for building with number of threads.
  nix.settings.max-jobs = lib.mkForce 12;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
