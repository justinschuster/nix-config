{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # Compatibility baseline for your initial Home Manager setup.
  # Keep this value when upgrading Home Manager later.
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    fd
    ripgrep
  ];

  programs.neovim.enable = true;
}
