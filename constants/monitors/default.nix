{
  # LG 32GP850 32" 16:9
  home-0.main = {
    fingerprint = builtins.readFile ./LG-32GP850.edid;
    width = 2560;
    height = 1440;
    rate = 120.0;
    scale = 1.75;
  };
  # TODO: Fix EDID.
  # Philips 345B1C 34" 21:9
  work.main = {
    fingerprint = builtins.readFile ./Philips-345B1C.edid;
    width = 3840;
    height = 1440;
    rate = 100.0;
    scale = 1.5;
  };

  utils = {
    toModeString = width: height: "${builtins.toString width}x${builtins.toString height}";
    posRightOf = monitor: "${builtins.toString monitor.width}x0";
  };
}
