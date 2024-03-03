{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.fonts;
in {
  options.modules.desktop.fonts.enable = lib.mkEnableOption "custom fonts";

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      # Fonts
      libertine
      inconsolata
      cm_unicode
      fira

      # Icon fonts
      material-design-icons
      font-awesome

      # Nerdfonts
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "FiraCode"
        ];
      })
    ];

    fonts.fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
    };
  };
}
