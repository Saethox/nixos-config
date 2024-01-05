{pkgs, ...}: {
  home.packages = with pkgs; [
    fishPlugins.done
    fishPlugins.forgit
    fishPlugins.hydro

    fzf
    fishPlugins.fzf-fish

    grc
    fishPlugins.grc
  ];
}
