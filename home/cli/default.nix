{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
  	gitui # Git Terminal UI
    nil # Nix language server
    alejandra # Nix formatter
  ];
}
