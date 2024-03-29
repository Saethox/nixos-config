# Global home-manager configuration file.
{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ./cli
    ./desktop
    ./dev
    ./profiles
    ./programs

    # Input modules.
    inputs.flatpaks.homeManagerModules.nix-flatpak # Declarative flatpaks
  ];

  # Default modules.
  modules.cli.common.enable = lib.mkDefault true;

  # Inherit username and home directory.
  home = {
    username = lib.mkDefault config.home.username;
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
  };

  # Link the configuration file in current directory to the specified location in home directory.
  # home.file.".config/xxx/wallpaper.jpg".source = ./wallpaper.jpg;

  # Link all files in `./scripts` to `~/.config/xxx/scripts`.
  # home.file.".config/xxx/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # Encode the file content in nix configuration file directly.
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager.
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";
}
