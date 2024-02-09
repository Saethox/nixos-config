{pkgs, ...}: {
  home.packages = with pkgs; [
    kate # Text editor
    keepassxc # Password manager
    signal-desktop # Signal client
    libsForQt5.kdeconnect-kde # Share files
    pympress # Presentation software
    inkscape # Inkscape
    pandoc # Document conversion
    zoom-us # Zoom client
    zotero # Literature management
    unstable.jetbrains-toolbox # Jetbrains Toolbox
    unstable.vscode-fhs # VS Code
    unstable.obsidian # Markdown knowledge base
    unstable.nextcloud-client # Nextcloud Desktop
    unstable.seafile-client # Seafile Desktop
    firefox
    (opera.override {proprietaryCodecs = true;})
  ];

  services.flatpak.packages = [
    "org.freefilesync.FreeFileSync" # File Synchronization & Backup
  ];
}
