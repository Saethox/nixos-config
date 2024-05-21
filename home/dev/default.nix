{pkgs, ...}: {
  imports = [
    ./rust.nix
    ./python.nix
    ./latex.nix
  ];

  home.packages = with pkgs.unstable; [
    devenv
  ];
}
