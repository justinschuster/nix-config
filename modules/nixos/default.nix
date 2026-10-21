# NixOS modules shared by every NixOS host.
{
  pkgs,
  hostname,
  username,
  ...
}:
{
  imports = [
    ../common
  ];

  networking.hostName = hostname;

  users.users."${username}" = {
    isNormalUser = true;
    home = "/home/${username}";
    description = username;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
