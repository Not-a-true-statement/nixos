{ pkgs, ...}:
{

    home.pointerCursor = {
        name = "Nordzy-cursors";
        size = 32;
        package = pkgs.nordzy-cursor-theme;
    };

    fonts.fontconfig.enable = true; #Update font cache
    dconf.enable = true;

    qt = {
        enable = true;
        platformTheme = "gtk";
    };

    gtk = {
        enable = true;
        theme = {
            name = "Juno-ocean";
            package = pkgs.juno-theme;
        };
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.pkgs.papirus-icon-theme;
        };
        # font = {
        # name = "JetBrains Mono Medium";         # or FiraCode Nerd Font Mono Medium
        # };                                        # Cursor is declared under home.pointerCursor
    };

        xresources = {
        properties = {
            "Xft.dpi" = 96;
            "Xcursor.size" = 32;

            "Xft.antialias" = 1;
            "Xft.hinting" =	1;
            "Xft.autohint" = 0;
            "Xft.hintstyle" = "hintslight";
            "Xft.rgba" = "rgb";
            "Xft.lcdfilter" = "lcddefault";

            "*foreground" = "#d9d7d6";
            "*background" = "#0A1419";
            "*cursorColor" = "#D9D7D6";

            "*color0" = "#1C252C";
            "*color8" = "#484E5B";

            "*color1" = "#DF5B61";
            "*color9" = "#F16269";

            "*color2" = "#78B892";
            "*color10" = "#8CD7AA";

            "*color3" = "#DE8F78";
            "*color11" = "#E9967E";

            "*color4" = "#6791C9";
            "*color12" = "#79AAEB";

            "*color5" = "#BC83E3";
            "*color13" = "#C488EC";

            "*color6" = "#67AFC1";
            "*color14" = "#7ACFE4";

            "*color7" = "#D9D7D6";
            "*color15" = "#E5E5E5";
        };
    };
}