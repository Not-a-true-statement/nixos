{...}:
{
  programs.bash = {
    enable = true;
    historySize = 100000;
    initExtra = ''
    # PS1= \n\H \u
    # tput lines
    # echo $LINES
    PS1="\e[0;31m\u@\h \w \e[m "
    PS1='\[$(tput cup "$LINES")\]'$PS1 # Place prompt at bottom
    '';
  };
}