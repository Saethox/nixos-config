{
  pkgs,
  lib,
  ...
}: {
  security.pam = {
    u2f = {
      enable = true;
      settings = {
        cue = true;
        cue_prompt = " Touch the Yubikey to continue...";
        interactive = false;
        origin = "pam://yubi";

        # generated with pamu2fcfg -n -o pam://yubi
        authfile = pkgs.writeText "u2f-mappings" (
          lib.concatStrings [
            "joni"
            ":rk3wZu5SDr5TizLMjbNgAp0LwgGrwlfN3RM3mg86t32LWnYJdTZfIOxoj6ubCWSaeA2lZ060EuJcfLLouAqDJQ==,zqQo0SOQpUEBl5d+P031rUV4TqIwc+iVsptE2nlHG3gM1oISMGkaqwtrY9GA5KKpKJwAVUTqxE0Xe077/+jTTg==,es256,+presence"
          ]
        );
      };
    };

    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };
}
