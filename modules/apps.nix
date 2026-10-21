{ pkgs, username, ... }: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    git
  ];
  environment.variables.EDITOR = "nvim";

  nix-homebrew = {
    enable = true;
    user = username;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [ ];

    # `brew install`
    brews = [
      "tree-sitter"
    ];

    # `brew install --cask`
    casks = [
      "claude-code"
      "firefox"
    ];
  };
}
