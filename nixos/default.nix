# Global config for all hosts.
{
  lib,
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [
    ./cli
    ./desktop
    ./hardware
    ./mounts
    ./services
    ./programs
    ./locale.nix
  ];

  # Default modules.
  modules.cli.common.enable = lib.mkDefault true;
  services.flatpak.enable = true;
  virtualisation.docker.enable = true;
  programs.nix-ld.enable = true;
  services.fwupd.enable = true;

  # Configure global nixpkgs instance.
  nixpkgs = {
    overlays =
      builtins.attrValues outputs.overlays
      ++ [
        # You can also add overlays exported from other flakes:
        # neovim-nightly-overlay.overlays.default

        # Or define it inline, for example:
        # (final: prev: {
        #   hi = final.hello.overrideAttrs (oldAttrs: {
        #     patches = [ ./change-hello-to-hi.patch ];
        #   });
        # })
      ];

    # Allow unfree packages.
    config.allowUnfree = true;
  };

  # Add each flake input as a registry to make nix3 commands consistent with this flake.
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # Add the inputs to the system's legacy channels, making legacy nix commands consistent as well.
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new `nix` command.
    experimental-features = ["nix-command" "flakes"];
    # Deduplicate and optimize nix store by default.
    auto-optimise-store = lib.mkDefault true;
    # Disable warning for dirty repository.
    warn-dirty = lib.mkDefault false;
    # Number of jobs used for building.
    max-jobs = lib.mkDefault 4;
    # Binary caches.
    substituters = [
      "https://cache.nixos.org?priority=10"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
      "https://nixpkgs-python.cachix.org"
      "https://cache.nixos-cuda.org"
      "https://cache.numtide.com"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  # Enable weekly nix store garbage collect.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
