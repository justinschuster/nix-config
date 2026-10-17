{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    neovim
    fd
    fzf
    jq
    ripgrep
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.zsh = {
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  xdg.enable = true;
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/src/config.nvim";
}
