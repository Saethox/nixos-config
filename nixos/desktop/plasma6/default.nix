{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.plasma6;
in {
  options.modules.desktop.plasma6 = {
    enable = lib.mkEnableOption "KDE Plasma 6 Desktop Environment";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.plasma6.enable = true;
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs;
    with kdePackages; [
      kate # Text editor
      filelight # Disk usage statistics
    ];
    programs.kdeconnect.enable = true;

    # Fonts.
    modules.desktop.fonts.enable = lib.mkDefault true;

    # Network Manager Plugins
    networking.networkmanager.plugins = with pkgs; [networkmanager-openvpn];
  };
}
