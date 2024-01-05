{pkgs, ...}: {
  home.packages = with pkgs; [
    kate # Text editor
    keepassxc # Password manager
    signal-desktop # Signal client
    pympress # Presentation software
    inkscape # Inkscape
    zoom-us # Zoom client
    unstable.jetbrains-toolbox # Jetbrains Toolbox
    unstable.vscode-fhs # VS Code
  ];

  # Enable firefox.
  # TODO: Manage extensions declaratively?
  # For now, use Firefox Sync.
  programs.firefox.enable = true;
}
