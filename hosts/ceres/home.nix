# home-manager configuration file of 'ceres' (replaces ~/.config/nixpkgs/home.nix).
{
  imports = [
    # Global home configuration.
    ../../home

    ../../home/desktop/x11/touchegg # Touchpad gestures

    # Device-specific home configuration.
    ./desktop/x11/autorandr # Monitor profiles
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
