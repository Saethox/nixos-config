{pkgs, ...}: {
  # Basic fish shell.
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };

  # Use fish shell by default.
  users.defaultUserShell = pkgs.fish;
}
