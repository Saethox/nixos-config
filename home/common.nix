{pkgs, ...}: {
  home.packages =
    (with pkgs; [
      kate # Text editor
      keepassxc # Password manager
      signal-desktop # Signal client
      pympress # Presentation software
      inkscape # Edit SVGs
      imagemagick # Edit bitmap images
      pandoc # Document conversion
      zoom-us # Zoom client
      zotero # Literature management
      gimp # Image editing
      gparted # Partition tool
      thunderbird # Email client
      firefox # Browser
      (opera.override {proprietaryCodecs = true;}) # Alternative Browser
    ])
    ++ (with pkgs.unstable; [
      jetbrains-toolbox # Jetbrains Toolbox
      vscode-fhs # VS Code
      obsidian # Markdown knowledge base
      nextcloud-client # Nextcloud Desktop
      seafile-client # Seafile Desktop
      jabref # Literature management
      zettlr # Alternative Obsidian
      mullvad-vpn # VPN (requires `services.mullvad-vpn`)
    ]);

  services.flatpak.packages = [
    "org.freefilesync.FreeFileSync" # File Synchronization & Backup
  ];

  services.kdeconnect.enable = true;
}
