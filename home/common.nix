{pkgs, ...}: {
  home.packages = with pkgs; [
      keepassxc
      signal-desktop
      pympress
      inkscape
      zoom-us
      unstable.jetbrains-toolbox
  ];

  # Enable firefox.
  programs.firefox.enable = true;
}
