{pkgs, ...}: {
  home.packages = with pkgs; [
      # ...
  ];

  # Enable firefox.
  programs.firefox.enable = true;
}
