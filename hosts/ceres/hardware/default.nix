{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    # nixos-hardware settings for Lenovo ThinkPad X1 Carbon Gen 11.
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-11th-gen
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking.
  networking.networkmanager.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable fingerprint.
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      # This driver seems to be correct.
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  # Enable laptop settings.
  modules.hardware.laptop.enable = true;
}
