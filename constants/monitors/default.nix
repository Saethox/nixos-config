{
  # LG 32GP850 32" 16:9
  home-0.main = {
    fingerprint = builtins.readFile ./LG-32GP850.edid;
    width = 2560;
    height = 1440;
    rate = 120.0;
    scale = 1.75;
  };
  # iiyama GE2788HS-B1 27" 16:9
  home-1.side = {
    fingerprint = builtins.readFile ./iiyama-GE2788HS-B1.edid;
    width = 1920;
    height = 1080;
    rate = 60.0;
    scale = 1.5;
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
    # Generates a "<width>x<height>" string.
    toModeString = width: height: "${builtins.toString width}x${builtins.toString height}";
    # Generates a position right of `monitor`.
    posRightOf = monitor: "${builtins.toString monitor.width}x0";
  };
}
