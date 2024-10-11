{ config, ... }: {

  imports = [
    ./programs.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  } ;
}
