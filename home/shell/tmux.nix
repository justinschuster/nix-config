{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;
    shortcut = "a";
    sensibleOnTop = true;
    plugins = with pkgs; [
    ];
    extraConfig = 
      ''
      '';
  };
}
