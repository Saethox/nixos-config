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

    # Fix scaling for `zoom-us`. Broken as of 2025-06-19.
    zoom-us = prev.zoom-us.overrideAttrs (oldAttrs: {
      passthru.unpacked = oldAttrs.unpacked.overrideAttrs (oldAttrs: {
        postFixup =
          oldAttrs.postFixup
          + ''
            wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE --set QT_SCALE_FACTOR 2
            wrapProgram $out/bin/zoom --unset XDG_SESSION_TYPE --set QT_SCALE_FACTOR 2
          '';
      });
    });

    # Fix build issues as of 2025-06-19.
    libfprint-2-tod1-vfs0090 =
      (prev.libfprint-2-tod1-vfs0090.override {
        libfprint-tod = prev.libfprint-tod.overrideAttrs (old: rec {
          version = "1.90.7+git20210222+tod1";
          src = old.src.overrideAttrs {
            rev = "v${version}";
            outputHash = "0cj7iy5799pchyzqqncpkhibkq012g3bdpn18pfb19nm43svhn4j";
            outputHashAlgo = "sha256";
          };
          buildInputs = (old.buildInputs or []) ++ [final.nss];
          mesonFlags = [
            "-Ddrivers=all"
            "-Dudev_hwdb_dir=${placeholder "out"}/lib/udev/hwdb.d"
          ];
        });
      })
      .overrideAttrs
      {meta.broken = false;};
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'.
  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  rolling-packages = final: prev: {
    rolling = import inputs.nixpkgs-rolling {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
