{pkgs, ...}: {
  fonts.packages = with pkgs; [
    # Fonts
    libertine
    inconsolata


    # Icon fonts
    material-design-icons
    font-awesome

    # Nerdfonts
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = ["JetBrainsMono Nerd Font"];
  };
}
