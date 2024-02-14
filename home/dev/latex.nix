{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    (texlive.combine {inherit (texlive) scheme-full libertine inconsolata biblatex newtx;})
  ];
}
