{pkgs, ...}: {
  home.packages = with pkgs; [
      # ...
  ];

  # Enable firefox.
  firefox.enable = true;
}
