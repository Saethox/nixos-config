{
  description = "nixos-config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Nixpkgs unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS hardware
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # Custom packages
    # Accessible through `nix build`, `nix shell`, etc.
    # TODO
    # packages = import ./pkgs nixpkgs.legacyPackages.${system};

    # Formatter for nix files, available through `nix fmt`.
    # TODO
    # formatter = nixpkgs.legacyPackages.${system}.alejandra;

    # Custom packages and modifications, exported as overlays.
    overlays = import ./overlays {inherit inputs;};

    # NixOS configuration entrypoint.
    # Available through `nixos-rebuild --flake .#<hostname>` or `just deploy`.
    nixosConfigurations = {
      # Work Laptop
      ceres = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # Global
          ./hosts/ceres/configuration.nix
          # Home
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              # Use the global nixpkgs instance.
              useGlobalPkgs = true;
              # Store user packages in `/etc/profiles/per-user/<username>`.
              useUserPackages = true;
              # User
              extraSpecialArgs = {inherit inputs outputs;};
              users.wurthjon = import ./hosts/ceres/home.nix;
            };
          }
        ];
      };
    };
  };
}
