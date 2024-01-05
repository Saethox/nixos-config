{pkgs, ...}: {
  programs.starship = {
    enable = true;
    package = pkgs.unstable.starship;
    enableFishIntegration = true;
    # Remove previous prompt for clarity.
    enableTransience = true;
  };
}
