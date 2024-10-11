{ pkgs, ... }: { 
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 16;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
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
