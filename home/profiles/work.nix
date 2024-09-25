{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.profiles.work;
in {
  options.modules.profiles.work.enable = lib.mkEnableOption "work packages";

  config = lib.mkIf cfg.enable {
    modules.dev.latex.enable = lib.mkDefault true;

    home.packages =
      (with pkgs; [
        pympress # Presentation software
        inkscape # Edit SVGs
        pandoc # Document conversion
        zoom-us # Zoom client
        # zotero # Literature management
        libreoffice-qt # Documents
      ])
      ++ (with pkgs.unstable; [
        jabref # Literature management
        zettlr # Alternative Obsidian
        eduvpn-client # eduVPN
        zotero # Literature management
      ]);

    services.flatpak.packages = [
      "org.freefilesync.FreeFileSync" # File Synchronization & Backup
    ];
  };
}
