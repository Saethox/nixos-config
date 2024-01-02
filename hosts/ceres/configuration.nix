# Configuration file of 'ceres' (replaces /etc/nixos/configuration.nix).
{
  inputs,
  ...
}: {
  imports = [
    # Global NixOS configuration.
    ../../nixos/global

    # NixOS configuration features.
    # ...

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Configure system-wide user settings (groups, etc), add more users as needed.
  users.users.wurthjon = {
      isNormalUser = true;
      description = "Jonathan Wurth";
      openssh.authorizedKeys.keys = [];
      extraGroups = [
        "wheel"
        "networkmanager"
        # "docker"
      ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
