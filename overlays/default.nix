# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # Fix scaling for `zoom-us`.
    zoom-us = prev.zoom-us.overrideAttrs (oldAttrs: {
      postFixup =
        oldAttrs.postFixup
        + ''
          wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE --set QT_SCALE_FACTOR 2
          wrapProgram $out/bin/zoom --unset XDG_SESSION_TYPE --set QT_SCALE_FACTOR 2
        '';
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'.
  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
      # Fix for obsidian using Electron 25, which is EOL.
      config.permittedInsecurePackages = ["electron-25.9.0"];
    };
  };
}
