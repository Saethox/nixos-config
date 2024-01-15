{outputs, ...}: let
  internal = {
    fingerprint = builtins.readFile ./internal.edid;
    width = 2880;
    height = 1800;
    rate = 90.0;
  };
in {
  services.autorandr = with outputs.constants.monitors; {
    enable = true;
    profiles = {
      "home-0" = {
        fingerprint = {
          eDP-1 = internal.fingerprint;
          HDMI-1 = home-0.main.fingerprint;
        };
        config = {
          eDP-1 = with internal; {
            enable = true;
            primary = true;
            mode = utils.toModeString width height;
            rate = builtins.toString rate;
          };
          HDMI-1 = with home-0.main; {
            enable = true;
            mode = utils.toModeString width height;
            rate = builtins.toString rate;
            scale.x = scale;
            scale.y = scale;
            position = utils.posRightOf internal;
          };
        };
      };
      "home-1" = {
        fingerprint = {
          eDP-1 = internal.fingerprint;
          HDMI-1 = home-1.side.fingerprint;
        };
        config = {
          eDP-1 = with internal; {
            enable = true;
            primary = true;
            mode = utils.toModeString width height;
            rate = builtins.toString rate;
          };
          HDMI-1 = with home-1.side; {
            enable = true;
            mode = utils.toModeString width height;
            rate = builtins.toString rate;
            scale.x = scale;
            scale.y = scale;
            position = utils.posRightOf internal;
          };
        };
      };
    };
  };
}
