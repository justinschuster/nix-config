{ pkgs, ... }: { 
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";

      scrolling.multiplier = 5;
      scrolling.history = 10000;
      selection.save_to_clipboard = true;

      window.dynamic_padding = true;
      window.padding = {
        x = 5;
        y = 5;
      };

      font = { 
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font Mono";
          style = "Italic";
        }; 
        size = 16;  
      };    
    };
  };

  programs.git = {
    enable = true;
    userName = "justinschuster";
    userEmail = "schujustin@gmail.com";
  }; 

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    #extraConfig = builtins.readFile /etc/nixos/config/nvim/init.lua;
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;
    clock24 = false;
    shortcut = "a";
    plugins = with pkgs; [  
    ]; 
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh ={
      enable = true;
      theme = "robbyrussell";
    };
  };

}
