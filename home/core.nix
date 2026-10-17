{ pkgs, ... }: {
  home.packages = with pkgs; [
    # utils
    fd
    fzf
    jq
    ripgrep
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    zsh = {
      oh-my-zsh = {
        enable = true;
	theme = "robbyrussell";
      };
    };
  };
}
