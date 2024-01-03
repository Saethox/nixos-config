# Global config for all hosts.
{lib, inputs, outputs, config, ...}: {
  imports = [
      ./locale.nix
      ./cli
  ];

  # Configure global nixpkgs instance.
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store by default.
    auto-optimise-store = lib.mkDefault true;
  };

  # Enable weekly nix store garbage collect.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}