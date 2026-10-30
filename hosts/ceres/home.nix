# home-manager configuration file of 'ceres' (replaces ~/.config/nixpkgs/home.nix).
{
  imports = [
    ../../home

    # Device-specific home configuration.
    # Add modules here.
  ];

  # Enable desktop programs.
  modules.programs.common.enable = true;

  # Enable Rust and Python.
  modules.dev.rust.enable = true;
  modules.dev.python3.enable = true;

  # Enable work profile.
  modules.profiles.work.enable = true;

  # Configure git to use work email.
  modules.cli.git.user = "work";

  # Configure ssh for runners.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      juno-runner = {
        HostName = "juno.local";
        User = "runner";
      };
      io-runner = {
        HostName = "io.local";
        User = "runner";
      };
      juno = {
        HostName = "juno.local";
        User = "joni";
      };
      io = {
        HostName = "io.local";
        User = "joni";
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
