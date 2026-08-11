{pkgs, ...}: {
  imports = [
    ./rust.nix
    ./python.nix
    ./latex.nix
  ];

  home.packages = with pkgs.rolling; [
    devenv
    claude-code
    codex
    opencode
  ];
}
