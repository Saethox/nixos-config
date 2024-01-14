{
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    # Login manager sddm has to be configured explicitly.
    displayManager.sddm = {
      enable = true;
      theme = lib.mkDefault "breeze";
      enableHidpi = true;
    };
    # Enable the KDE Plasma Desktop Environment.
    desktopManager.plasma5.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.bismuth # Bismuth window tiling manager extension
    libsForQt5.breeze-qt5 # Breeze theme
  ];
}
