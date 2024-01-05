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

  programs.fish = {
    enable = true;
    functions = {
      # Disable greeting.
      fish_greeting = "";
    };
  };
}
