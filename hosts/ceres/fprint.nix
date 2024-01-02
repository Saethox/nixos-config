{pkgs, ...}: {
  # Enable fingerprint.
  services.fprind = {
    enable = true;
    tod = {
      enable = true;
      # This driver seems to be correct.
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };
}