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

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.enable = true;
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/config.nvim";
}
