{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./eza.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    gitui # Git Terminal UI
    nil # Nix language server
    alejandra # Nix formatter
    nix-output-monitor # Build tree tool
    nvd # Upgrade diff
    nh # Useful nix tools
  ];
}
