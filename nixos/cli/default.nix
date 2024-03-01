{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.cli;
in {
  imports = [
    ./fish.nix
  ];

  options.modules.cli.enable = lib.mkEnableOption "cli";

  config = lib.mkIf cfg.enable {
    # Enable submodules.
    modules.cli.fish.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      # Fetch files from the internet.
      wget
      curl

      # ZIP archive tools.
      zip
      unzip

      xclip # Clipboard

      neofetch # Display system information
      micro # Text editor with mouse support
      just # Command runner
      htop # System monitor
    ];
  };
}
