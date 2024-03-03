{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.plasma5;
in {
  options.modules.desktop.plasma5 = {
    enable = lib.mkEnableOption "KDE Plasma Desktop Environment";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
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
      arandr # GUI for xrandr
    ];

    # Monitor profiles.
    services.autorandr.enable = true;

    # Touchpad settings.
    services.xserver.libinput.enable = lib.mkDefault true;
    services.touchegg.enable = lib.mkDefault true;

    # Fonts.
    modules.desktop.fonts.enable = lib.mkDefault true;
  };
}
