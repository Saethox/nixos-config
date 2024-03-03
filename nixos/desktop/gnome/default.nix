{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.gnome;
in {
  options.modules.desktop.gnome = {
    enable = lib.mkEnableOption "Gnome Desktop Environment";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gnomeExtensions.gesture-improvements # Touchpad gestures
    ];

    # Fonts.
    modules.desktop.fonts.enable = lib.mkDefault true;
  };
}
