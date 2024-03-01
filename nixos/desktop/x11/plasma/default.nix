{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.x11.plasma;
in {
  options.modules.desktop.x11.plasma = {
    enable = lib.mkEnableOption "KDE Plasma Desktop Environment";
  };

  config = lib.mkIf cfg.enable {
    modules.desktop.x11.enable = true;

    services.xserver = {
      desktopManager.plasma5.enable = true;
      # Login manager sddm has to be configured explicitly.
      displayManager.sddm = {
        enable = true;
        theme = lib.mkDefault "breeze";
        enableHidpi = true;
      };
    };

    environment.systemPackages = with pkgs; [
      libsForQt5.bismuth # Bismuth window tiling manager extension
      libsForQt5.breeze-qt5 # Breeze theme
    ];
  };
}
