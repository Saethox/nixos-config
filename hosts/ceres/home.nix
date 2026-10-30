# home-manager configuration file of 'ceres' (replaces ~/.config/nixpkgs/home.nix).
{
  imports = [
    ../../home

    # Device-specific home configuration.
    # Add modules here.
  ];

  # Enable desktop programs.
  modules.programs.common.enable = true;

  # Enable devtools.
  modules.dev.rust.enable = true;
  modules.dev.python3.enable = true;
  modules.dev.llm.enable = true;

  # Enable work profile.
  modules.profiles.work.enable = true;

  # Configure git to use work email.
  modules.cli.git.user = "work";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
