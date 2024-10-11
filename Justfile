deploy:
  nixos-rebuild swtich --flake . --use-remote-sudo

debug:
  nixos-rebuild switch --flake, --use-remote-sudo --show-trace --verbose

up:
  nix flake update

clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

dell:
  sudo: nixos-rebuild switch --flake .#dell-laptop
