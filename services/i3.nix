{ pkgs, ...}: {

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw  

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
        defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        i3lock #default i3 screen locker 
        i3status
     ];
    };

    xkb = {
      layout = "us";
      variant = "";
    };

  };

}
