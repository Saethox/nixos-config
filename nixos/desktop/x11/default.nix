{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.x11;
in {
  imports = [
    ./plasma
  ];

  options.modules.desktop.x11 = {
    enable = lib.mkEnableOption "x11";
    touchpad = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "touchpad";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;

    environment.systemPackages = with pkgs; [
      arandr # GUI for xrandr
    ];

    # Monitor profiles.
    services.autorandr.enable = true;

    # Touchpad settings.
    services.xserver.libinput.enable = lib.mkDefault cfg.touchpad;
    services.touchegg.enable = lib.mkDefault cfg.touchpad;
  };
}
