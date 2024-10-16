{ config, ... }: {

  imports = [
    ./tmux.nix
    ./programs.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  } ;
}
