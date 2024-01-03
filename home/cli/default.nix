{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
  	gitui
  ];
}
