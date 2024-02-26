{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.cli;
in {
  imports = [
    ./direnv.nix
    ./eza.nix
    ./fish.nix
    ./starship.nix
  ];

  options.modules.cli.enable = lib.mkOption {
    default = false;
    example = true;
    description = "Enable CLI tools.";
  };

  config = lib.mkIf cfg.enable {
    # Enable submodules.
    modules.direnv.enable = lib.mkDefault true;
    modules.eza.enable = lib.mkDefault true;
    modules.fish.enable = lib.mkDefault true;
    modules.starship.enable = lib.mkDefault true;

    # Other packages.
    home.packages =
      (with pkgs; [
        fzf # Fuzzy finder
        grc # Text colorizer
      ])
      ++ (with pkgs.unstable; [
        gitui # Terminal git UI
        nil # Nix language server
        alejandra # Nix formatter
        nix-output-monitor # Build tree tool
        nvd # Upgrade diff
        nh # Useful nix tools
        rm-improved # Better `rm` (rip)
        ripgrep # Better `grep` (rg)
        fd # Better `find`
        bat # Better `cat`
        zoxide # Better `cd` (z)
        fend # Calculator
        bottom # System monitor
        broot # Navigate directories
        zellij # Better `tmux`
        nushell # Alternative shell
        sad # Search and replace
        tealdeer # Faster `tldr`
      ]);
  };
}
