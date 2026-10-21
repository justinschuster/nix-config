{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    fd
    fzf
    go
    jq
    neovim
    nil
    nixfmt
    ripgrep
    tmux
  ];

  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.enable = true;
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/config.nvim";
}
