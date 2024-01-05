# NixOS Configuration

My personal [NixOS](https://nixos.org/) configuration.

> Mostly, I have no idea what I'm doing.

Deploy the configuration with:
```sh
$ just deploy 
```

## Hosts

- Ceres (Lenovo Thinkpad X1 Carbon Gen 11)

## Structure

- `home` ++ User environment managed with [`home-manager`](https://github.com/nix-community/home-manager)
- `hosts` ++ Host-specific configuration
  - `ceres`
    - `configuration.nix` ++ System configuration
    - `hardware-configuration.nix` ++ Auto-generated hardware configuration
    - `home.nix` ++ User configuration
- `nixos` ++ System environment
- `overlays` ++ Custom overlays
- `pkgs` ++ Custom packages
- `flake.nix` ++ Entrypoint
- `justfile` ++ Useful commands
