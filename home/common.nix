{pkgs, ...}: {
  home.packages = with pkgs; [
      keepassxc
      signal-desktop
      pympress
      inkscape
      zoom-us
      unstable.jetbrains-toolbox
      unstable.vscode-fhs
  ];

  # Enable firefox.
  programs.firefox.enable = true;
}
