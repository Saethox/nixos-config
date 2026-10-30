{
  pkgs,
  ...
}: {
  imports = [
    ./rust.nix
    ./python.nix
    ./latex.nix
    ./llm.nix
  ];

  home.packages = with pkgs.rolling; [
    devenv
    gh
  ];
}
