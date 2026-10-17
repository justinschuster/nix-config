#!/bin/bash
set -euo pipefail

NEOVIM_CONFIG_PATH="${HOME}/src/config.nvim"
NEOVIM_CONFIG_REPO_URL="https://github.com/justinschuster/config.nvim.git"

install_homebrew() {
  if command -v brew >/dev/null 2>&1 ||
     [[ -x /opt/homebrew/bin/brew ]]; then
    echo "Homebrew is already installed."
    return
  fi

  echo "Installing Homebrew..."
  local installer
  installer="$(curl -fsSL \
    https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  /bin/bash -c "$installer"
}

install_neovim_config() {
  if [[ -d "${NEOVIM_CONFIG_PATH}/.git" ]]; then
    echo "Existing checkout found at ${NEOVIM_CONFIG_PATH}; skipping."
    return
  fi

  if [[ -e "$NEOVIM_CONFIG_PATH" || -L "$NEOVIM_CONFIG_PATH" ]]; then
    echo "Cannot clone: ${NEOVIM_CONFIG_PATH} already exists." >&2
    exit 1
  fi

  echo "Cloning Neovim configuration into ${NEOVIM_CONFIG_PATH}..."
  mkdir -p "$(dirname "$NEOVIM_CONFIG_PATH")"
  git clone "$NEOVIM_CONFIG_REPO_URL" "$NEOVIM_CONFIG_PATH"
}

install_homebrew
install_neovim_config

echo "Setup complete. Run make deploy from your nix-config repository."
