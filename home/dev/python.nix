{pkgs, ...}: {
  home.packages = with pkgs; [
    # Latest stable Python with useful packages.
    (python3.withPackages (ps: with ps; [ipython numpy pandas matplotlib seaborn pygments]))
    poetry # Dependency management
    (builtins.getFlake "github:GuillaumeDesforges/fix-python/c9c8e8a439e0c985d0c5cea757d806837cf322f1") # Path .venv with `fix-python`
  ];
}
