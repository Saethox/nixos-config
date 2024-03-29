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
        mullvad-vpn # VPN (requires `services.mullvad-vpn`)
      ]);
  };
}
