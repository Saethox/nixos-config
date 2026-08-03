{pkgs, ...}: {
  imports = [
    ./rust.nix
    ./python.nix
    ./latex.nix
  ];

  home.packages = (with pkgs.unstable; [
    devenv
  ]) ++ (with pkgs.rolling; [
    claude-code
    codex
    opencode
  ]);
}
