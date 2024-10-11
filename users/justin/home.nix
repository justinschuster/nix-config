{ pkgs, ...}: {
  imports = [
    ../../home/core.nix

    ../../home/i3
    ../../home/rofi
    ../../home/shell
  ];

}
