{pkgs, ...}: {
  home.packages = with pkgs; [
    kate # Text editor
    keepassxc # Password manager
    signal-desktop # Signal client
    pympress # Presentation software
    inkscape # Inkscape
    zoom-us # Zoom client
    zotero # Literature management
    texliveTeTeX # LaTeX / XeTeX with many packages
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
