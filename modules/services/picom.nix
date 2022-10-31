{...}:
{
    services.picom = {
        enable = true;
        vSync = true;
        experimentalBackends = true;
        backend = "glx";

        settings = {
            
            blur = {
                    method = "gaussian";
                    size = 10;
                    deviation = 5.0;
            };
            blur-background-exclude = {
                # "window_type" = "dock";
                # "window_type" = "desktop";
                # class_g = "Plank";
                # class_g = "polybar";
                # class_g = "slop";
                # class_g = "Chromium";
                # # "_GTK_FRAME_EXTENTS@:c";
            };

            # wintypes = {
            #     dock = { blur = false; };
            
            # # tooltip = { fade = true; shadow = true; opacity = 0.75; focus = true; full-shadow = false; };
            # # dock = { shadow = false; clip-shadow-above = true; };
            # # dnd = { shadow = false; };
            # # popup_menu = { opacity = 0.8; };
            # # dropdown_menu = { opacity = 0.8; };
            # };
        };
    };
}