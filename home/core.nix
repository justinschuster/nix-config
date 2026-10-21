{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    neovim
    nil
    nixfmt
    go
    fd
    fzf
    jq
    ripgrep
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
