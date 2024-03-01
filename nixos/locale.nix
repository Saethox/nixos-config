{lib, ...}: {
  # Set language to "en_US" by default.
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  # Set other locale settings to "de_DE" by default.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = lib.mkDefault "de_DE.UTF-8";
    LC_IDENTIFICATION = lib.mkDefault "de_DE.UTF-8";
    LC_MEASUREMENT = lib.mkDefault "de_DE.UTF-8";
    LC_MONETARY = lib.mkDefault "de_DE.UTF-8";
    LC_NAME = lib.mkDefault "de_DE.UTF-8";
    LC_NUMERIC = lib.mkDefault "de_DE.UTF-8";
    LC_PAPER = lib.mkDefault "de_DE.UTF-8";
    LC_TELEPHONE = lib.mkDefault "de_DE.UTF-8";
    LC_TIME = lib.mkDefault "de_DE.UTF-8";
  };

  # Configure keymap
  console.keyMap = "de";
  services.xserver = {
    layout = "de";
    xkbVariant = "nodeadkeys";
  };

  # Set timezone.
  time.timeZone = lib.mkDefault "Europe/Berlin";
}
