# home-manager configuration file of 'juno' (replaces ~/.config/nixpkgs/home.nix).
{
  imports = [
    ../../home

    # Device-specific home configuration.
    # Add modules here.
  ];

  # Enable desktop programs.
  modules.programs.common.enable = true;

  # Enable python.
  modules.dev.python3.enable = true;

  # Enable personal profile.
  modules.profiles.personal.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
