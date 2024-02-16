{pkgs, ...}: {
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
}
