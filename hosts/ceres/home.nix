# home-manager configuration file of 'ceres' (replaces ~/.config/nixpkgs/home.nix).
{inputs, ...}: {
  imports = [
    ../../home

    # Use CLI tools.
    ../../home/cli
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
