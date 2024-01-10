{
  services.autorandr = {
    enable = true;
    profiles = {
      "work" = {
        fingerprint = {
          phillips-345b = "${builtins.readFile ./Phillips-345B.txt}";
        };
        config = {
          phillips-345b = {
            enable = true;
            scale = {
              x = 2;
              y = 2;
            };
          };
        };
      };
    };
  };
}
