{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./eza.nix
    ./starship.nix
    ./direnv.nix
  ];

  home.packages =
    # Stable packages.
    (with pkgs; [
      fzf # Fuzzy finder
      grc # Text colorizer
    ])
    ++
    # Unstable (and therefore fancy cutting-edge) packages.
    (with pkgs.unstable; [
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
}
