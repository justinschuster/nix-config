{ pkgs, username, unstable, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # Compatibility baseline for your initial Home Manager setup.
  # Keep this value when upgrading Home Manager later.
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    fd
    ripgrep
  ];

  programs.neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;

      package = unstable.neovim-unwrapped;
  };

  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };
}
