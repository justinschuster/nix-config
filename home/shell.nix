{ ... }: {
  programs.zsh = {
    enable = true;

    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    oh-my-zsh = {
      enable = true;
      theme = "nicoulaj";
    };
  };
}
