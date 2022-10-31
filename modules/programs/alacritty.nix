{ pkgs, ... }:
let
  themes = import (../themes/colors.nix);
  theme = themes.scheme.default;
in
{
    programs.alacritty = {
        enable = true;
        package = pkgs.alacritty;

        settings = with theme; {
            window = {
                # opacity = 0.95;
                dynamic_padding = true;
                padding= {
                    x = 20;
                    y = 20;
                };
            };

            cursor = {
                style = "Underline";
            };


            font = {
                size = 12;
                
                normal = {
                    # family = "DMC5Font";
                    # family = "iosevka";
                    style = "Regular";
                };
            };

            colors = {
                cursor = {
                    text = "CellForeground";
                    cursor = "#${foreground}";
                };

                primary = {
                    background = "#${background}";
                    foreground = "#${foreground}";
                };

                normal = {
                    black = "#${color0}";
                    red = "#${color1}";
                    green = "#${color2}";
                    yellow = "#${color3}";
                    blue = "#${color4}";
                    magenta = "#${color5}";
                    cyan = "#${color6}";
                    white = "#${color7}";
                };

                bright = {
                    black = "#${color8}";
                    red = "#${color9}";
                    green = "#${color10}";
                    yellow = "#${color11}";
                    blue = "#${color12}";
                    magenta = "#${color13}";
                    cyan = "#${color14}";
                    white = "#${color15}";
                };
            };

            live_config_reload = true;
        };

    };
}