{ username, ... }: {
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
