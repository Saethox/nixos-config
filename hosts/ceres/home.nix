# home-manager configuration file of 'ceres' (replaces ~/.config/nixpkgs/home.nix).
{
  imports = [
    ../../home

    # Device-specific home configuration.
    # Add modules here.
  ];

  # Enable plasma touchpad gestures.
  modules.desktop.x11.plasma.gestures.enable = true;

  # Enable desktop programs.
  modules.desktop.programs.enable = true;
  
  # Enable Rust and Python.
  modules.dev.rust.enable = true;
  modules.dev.python3.enable = true;

  # Enable work profile.
  modules.profiles.work.enable = true;

  # Configure git to use work email.
  modules.cli.git.user = "work";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
