{pkgs, ...}: {
  home.packages = with pkgs.fishPlugins; [
    done # Notifications
    forgit # Git additions
    # hydro # Prompt
    fzf-fish # Key bindings for fzf
    grc # Colorize zsing grc
    autopair # Matching pairs
    puffer # Text expansion
  ];

  programs.fish = {
    enable = true;
    functions = {
      # Disable greeting.
      fish_greeting = "";
    };
  };
}
