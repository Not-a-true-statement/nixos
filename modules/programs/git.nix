{ pkgs, ... }:

{
    programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userEmail = "drunkcenter@live.com";
    userName = "Not-a-true-statement";
  };

# home.extraProfileCommands = ''
#     ${pkgs.betterdiscordctl}/bin/betterdiscordctl install
# '';
}