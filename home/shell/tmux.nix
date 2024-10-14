{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;
    shortcut = "a";
    plugins = with pkgs; [
      sensible;
    ];
    extraConfig = 
      ''
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # faster pane switching
      bind C-n next-window
      bind C-p previous-window
      ''
  };
}
