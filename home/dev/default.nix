{pkgs, ...}: {
  imports = [
    ./rust.nix
    ./python.nix
    ./latex.nix
  ];

  home.packages = with pkgs.rolling; [
    devenv
    gh
    claude-code
    codex
    opencode
  ];
}
