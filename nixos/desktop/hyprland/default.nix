{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
in {
  options.modules.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = pkgs.unstable.hyprland;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.unstable.xdg-desktop-portal-hyprland];
    };

    security.pam.service.swaylock = {};

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };

    environment.systemPackages = with pkgs.unstable; [
      libsForQt5.qt5.qtwayland # qt5 for wayland
      kdePackages.qtwayland # qt6 for wayland
    ];

    # Fonts.
    modules.desktop.fonts.enable = lib.mkDefault true;
  };
}
