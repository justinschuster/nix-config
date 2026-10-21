# Home Manager config for Linux (NixOS) hosts only.
{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
  };
}
