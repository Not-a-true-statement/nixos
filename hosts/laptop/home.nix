{ pkgs, ... }:

{
  imports =
    [
      #System specific configuration
    ];

  home = {
    # Specific packages for laptop
    packages = with pkgs; [
      # Display
      #light                              # xorg.xbacklight not supported. Other option is just use xrandr.

      # Power Management
      #auto-cpufreq                       # Power management
      #tlp                                # Power management
    ];
  };

  services = {                            # Applets
    # blueman-applet.enable = true;         # Bluetooth
#   network-manager-applet.enable = true; # Network
#   cbatticon = {
#     enable = true;
#     criticalLevelPercent = 10;
#     lowLevelPercent = 20;
#     iconType = null;
#   };
  };
}
