# home-manager configuration file of 'juno' (replaces ~/.config/nixpkgs/home.nix).
{
  imports = [
    # Global home configuration.
    ../../home

    # Device-specific home configuration.
    # Add modules here.
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
