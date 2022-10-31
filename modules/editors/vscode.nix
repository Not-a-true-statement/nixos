{ pkgs, ... }:
let
  themes = import (../themes/colors.nix);
  theme = themes.scheme.default;
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    extensions = [];
    userSettings = with theme; {
      "update.mode" = "none";
      "workbench.startupEditor" = "none";
      "Lua.telemetry.enable" = false;
      "telemetry.telemetryLevel" = "off";
      "window.menuBarVisibility" = "toggle";
      "workbench.colorTheme" = "Dark+";
      "workbench.colorCustomizations" = {
        "activityBar.background" = "#${background}";
        "activityBar.foreground" = "#${foreground}";
        "activityBar.border" = "#${color0}";
        "sideBar.background" = "#${color0}";
        "sideBar.foreground" = "#${foreground}";
        "editor.background" = "#${background}";
        "editorGroupHeader.tabsBackground" = "#${color0}";
      };
    };
  };
}

