{
  programs.git = {
    enable = true;
    # Enable Git Large File Storage.
    lfs.enable = true;
    extraConfig = {
      # Rebase by default on `git pull`.
      pull.rebase = true;
      github.user = "Saethox";
    };
    ignores = [
      ".idea"
      ".direnv"
      ".envrc"
    ];
  };
}
