{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = {
      with pkgs.vimPlugins; [
        vim-sleuth
        lazy-nvim
        comment-nvim
        which-key-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
      ];
    };
  };
}
