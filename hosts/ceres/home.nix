# home-manager configuration file of 'ceres' (replaces ~/.config/nixpkgs/home.nix).
{
  imports = [
    ../../home
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
