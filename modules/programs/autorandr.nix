let
  
in
{
    programs.autorandr = {
      enable = true;

      profiles."default" = {
        fingerprint = {
          DP-0 = "00ffffffffffff0010ac14a1424432361b1e0104a5301b783ac7b5a756539c27105054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c4500dc0b1100001e000000ff004236474d3434330a2020202020000000fc0044454c4c205032323139480a20000000fd00384c1e5311010a202020202020001d";
          HDMI-0 = "00ffffffffffff003669a83c010101011b1f0103803c2278ee55b5ab5146ab260b50543fcf00d1c001010101010181809500b3000101565e00a0a0a0295030203500544f2100001e000000fd0030901ef33c000a202020202020000000fc004d53492047323733510a202020000000ff0043413841363431363030363235018b02033d714e020311121304292f901f403f615f230917078301000067030c002000183c67d85dc4017880006d1a0000020130a5ec0000000000e305e30111e2008ca0a0325026204808544f2100001e6fc200a0a0a0555030203500544f2100001e59928096703812401c203500544f2100001a00000000000000000000000032";
        };

        config = {
          DP-0 = {
            enable = true;
            primary = true;
            rotate = "normal";
            mode = "1920x1080";
            position = "320x0";
          };

          HDMI-0 = {
            enable = true;
            rotate = "normal";
            mode = "2560x1440";
            position = "0x1080";
          };  
        };

        hooks.preswitch = ''
        ddcutil --sn=CA8A641600625 setvcp 60 0x12
        '';
        hooks.postswitch = ''
        systemctl --user restart barrierc.service
        echo 'awesome.restart()' | awesome-client
        '';
      };

      profiles."game" = {
        fingerprint = {
          DP-0 = "00ffffffffffff0010ac14a1424432361b1e0104a5301b783ac7b5a756539c27105054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c4500dc0b1100001e000000ff004236474d3434330a2020202020000000fc0044454c4c205032323139480a20000000fd00384c1e5311010a202020202020001d";
        };

        config = {
          DP-0 = {
            enable = true;
            primary = true;
            rotate = "normal";
            mode = "1920x1080";
            position = "0x0";
          };
        };

        hooks.preswitch = ''
        ddcutil --sn=CA8A641600625 setvcp 60 0x0f
        '';
        hooks.postswitch = ''
        systemctl --user restart barrierc.service
        echo 'awesome.restart()' | awesome-client
        '';
      
      };
    };
}