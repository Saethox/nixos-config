{pkgs, ...}: {
  home.packages = with pkgs; [
    (texlive.combine {inherit (texlive) scheme-full libertine inconsolata biblatex newtx;})
  ];
}
