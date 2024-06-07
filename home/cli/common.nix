{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.cli.common;
in {
  options.modules.cli.common.enable = lib.mkEnableOption "common cli tools";

  config = lib.mkIf cfg.enable {
    modules.cli.direnv.enable = lib.mkDefault true;
    modules.cli.eza.enable = lib.mkDefault true;
    modules.cli.fish.enable = lib.mkDefault true;
    modules.cli.starship.enable = lib.mkDefault true;
    modules.cli.git.enable = lib.mkDefault true;

    # Other packages.
    home.packages =
      (with pkgs; [
        fzf # Fuzzy finder
        grc # Text colorizer
        mc # File manager
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
