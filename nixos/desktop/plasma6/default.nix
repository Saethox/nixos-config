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
    services.xserver = {
      enable = true;
      desktopManager.plasma6.enable = true;
      displayManager.gdm.enable = true;
    };

    environment.systemPackages = with pkgs; with kdePackages; [
      kate # Text editor
    ];

    # Fonts.
    modules.desktop.fonts.enable = lib.mkDefault true;
  };
}
