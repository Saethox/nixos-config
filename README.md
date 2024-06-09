# NixOS Configuration

My personal [NixOS](https://nixos.org/) configuration.

> For the most part, I have no idea what I'm doing.

Deploy the configuration with:
```sh
$ just deploy 
```

## Hosts

- Ceres (Lenovo Thinkpad X1 Carbon Gen 11)
- Juno (Lenovo ThinkBook 16p Gen 2 ACH)
- Titan (AMD Ryzen 5600X + Nvidia GeForce 1660 Ti Desktop PC)

## Structure

- `constants` ++ Read-only data
- `home` ++ User environment managed with [`home-manager`](https://github.com/nix-community/home-manager)
- `hosts` ++ Host-specific configuration
  - `ceres`
    - `hardware` ++ Auto-generated hardware configuration
    - `configuration.nix` ++ System configuration
    - `home.nix` ++ User configuration
- `modules`
  - `home-manager` ++ Custom `home-manager` modules
  - `nixos` ++ Custom system modules 
- `nixos` ++ System environment
- `overlays` ++ Custom overlays
- `pkgs` ++ Custom packages
- `secrets` ++ Secrets not tracked by `git`
- `flake.nix` ++ Entrypoint
- `justfile` ++ Useful commands
