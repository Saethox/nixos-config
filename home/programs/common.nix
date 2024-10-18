{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.common;
in {
  options.modules.programs.common.enable = lib.mkEnableOption "common desktop packages";

  config = lib.mkIf cfg.enable {
    home.packages =
      (with pkgs; [
        keepassxc # Password manager
        signal-desktop # Signal client
        spotify # Music streaming
        gimp # Image editing
        gparted # Partition tool
        thunderbird # Email client
        firefox # Browser
        vlc # Media player
        vscode-fhs # VS Code
      ])
      ++ (with pkgs.unstable; [
        jetbrains-toolbox # Jetbrains Toolbox
        obsidian # Markdown knowledge base
        nextcloud-client # Nextcloud Desktop
        keymapp # Application for ZSA keyboards
      ]);
  };
}
