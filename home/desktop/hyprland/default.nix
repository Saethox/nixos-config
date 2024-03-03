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
    nvidia = lib.mkEnableOption "Nvidia";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        env = [
          "NIXOS_OZONE_WL,1" # Hint electron apps to use wayland

          # Firefox on Wayland.
          "MOZ_ENABLE_WAYLAND,1"
          "MOZ_WEBRENDER,1"
        ];
      };
      systemd.enable = true;
    };

    home.packages = with pkgs.unstable; [
      hyprpaper # Wallpaper
      swaynotificationcenter # Notifications
      swaylock-effects # Lock Screen
      swayidle # Idle manager
      rofi-wayland # Task runner
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      })) # Status bar
      kitty # Terminal
      wlogout # Logout menu
      wl-clipboard # Clipboard
      networkmanagerapplet # Network GUI
    ];

    # https://wiki.hyprland.org/Nvidia/
    wayland.windowManager.hyprland.env = lib.mkIf cfg.nvidia [
      "LIBVA_DRIVER_NAME,nvidia"
      "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      # Fix https://github.com/hyprwm/Hyprland/issues/1520.
      "WLR_NO_HARDWARE_CURSORS,1"
    ];
  };
}
