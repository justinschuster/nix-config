{
  pkgs,
  config,
  ...
}: {

  # config files
  home.file.".config/i3/config".source = ./config;
  home.file.".config/i3/keybindings".source = ./keybindings;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };
}
