{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.dev.rust;
  concatList = builtins.concatStringsSep " ";
in {
  options.modules.dev.rust.enable = lib.mkEnableOption "rust";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        # `hiPrio` is needed because `llvm-binutils-wrapper/bin/ranlib` collides with `clang-wrapper/bin/ranlib`.
        (hiPrio clang)
        # Replace llvmPackages with llvmPackages_X, where X is the latest LLVM version (at the time of writing, 17).
        llvmPackages_17.bintools
        rustup
      ];

      # Set environment variables.
      sessionVariables = {
        # https://github.com/rust-lang/rust-bindgen#environment-variables
        LIBCLANG_PATH = pkgs.lib.makeLibraryPath [pkgs.llvmPackages_latest.libclang.lib];
        # Add precompiled library to rustc search path.
        RUSTFLAGS = concatList (builtins.map (a: ''-L ${a}/lib'') [
          # add libraries here (e.g. pkgs.libvmi)
        ]);
        # Add glibc, clang, glib and other headers to bindgen search path.
        BINDGEN_EXTRA_CLANG_ARGS = concatList (
          # Includes with normal include path.
          (builtins.map (a: ''-I"${a}/include"'') [
            # add dev libraries here (e.g. pkgs.libvmi.dev)
            pkgs.glibc.dev
          ])
          # Includes with special directory paths.
          ++ [
            ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
            ''-I"${pkgs.glib.dev}/include/glib-2.0"''
            ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
          ]
        );
      };
    };
  };
}
