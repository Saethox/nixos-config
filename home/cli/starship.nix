{pkgs, ...}: {
  programs.starship = {
    enable = true;
    package = pkgs.unstable.starship;
    settings = {
      enable_transience = true;
    };
  };
}