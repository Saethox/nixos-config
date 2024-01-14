{pkgs, ...}: {
  # Basic fish shell.
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
    shellAliases = {
      to-clipboard = "xclip -selection c";
    };
  };

  # Use fish shell by default.
  users.defaultUserShell = pkgs.fish;
}
