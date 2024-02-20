{pkgs, ...}: {
  home.packages = with pkgs.fishPlugins; [
    done # Notifications
    forgit # Git additions
    fzf-fish # Key bindings for fzf
    grc # Colorize using grc
    autopair # Matching pairs
    puffer # Text expansion
  ];

  programs.fish = {
    enable = true;
    functions = {
      # Disable greeting.
      fish_greeting = "";
    };
    interactiveShellInit = ''
      zoxide init fish | source
    '';
  };
}
