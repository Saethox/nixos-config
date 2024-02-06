{pkgs, ...}: {
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    layout = "de";
    xkbVariant = "nodeadkeys";
  };

  environment.systemPackages = with pkgs; [
    arandr # GUI for xrandr
  ];

  # Monitor profiles.
  services.autorandr.enable = true;
}
