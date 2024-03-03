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
      gnomeExtensions.swap-finger-gestures-3-to-4
    ];

    # Fonts.
    modules.desktop.fonts.enable = lib.mkDefault true;
  };
}
