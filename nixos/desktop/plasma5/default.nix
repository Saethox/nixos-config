{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.plasma5;
in {
  options.modules.desktop.plasma5 = {
    enable = lib.mkEnableOption "KDE Plasma 5 Desktop Environment";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
    };

    # Login manager sddm has to be configured explicitly.
    services.displayManager.sddm = {
      enable = true;
      theme = lib.mkDefault "breeze";
      enableHidpi = true;
    };

    environment.systemPackages = with pkgs;
    with libsForQt5; [
      kate # Text editor
      bismuth # Bismuth window tiling manager extension
      breeze-qt5 # Breeze theme
      arandr # GUI for xrandr
    ];

    # Monitor profiles.
    services.autorandr.enable = true;

    # Touchpad settings.
    services.libinput.enable = lib.mkDefault true;
    services.touchegg.enable = lib.mkDefault true;

    # Fonts.
    modules.desktop.fonts.enable = lib.mkDefault true;
  };
}
