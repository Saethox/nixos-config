{pkgs, ...}: {
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    layout = "de";
    xkbVariant = "";
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  environment.systemPackages = with pkgs; [
    arandr # GUI for xrandr
  ];
}
