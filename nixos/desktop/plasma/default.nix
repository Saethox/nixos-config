{pkgs, ...}: {
  # Enable the KDE Plasma Desktop Environment.
  services.xserver = {
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.bismuth # Bismuth window tiling manager extension
  ];
}
