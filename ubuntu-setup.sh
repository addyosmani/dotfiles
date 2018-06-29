#!/bin/bash

# Catch and log errors
trap uncaughtError ERR
function uncaughtError {
  echo -e "\n\t❌  Error\n"
  echo "$(<${ERROR_LOG})"
  echo -e "\n\t😞  Sorry\n"
  exit $?
}

function initTempDir() {
  TEMP_DIR="$(mktemp -d)"
  ERROR_LOG="${TEMP_DIR}/dotfile-install-err.log"
}

function installCommonDeps() {
  echo -e "📦  Installing common dependencies..."
  sudo apt-get install -y curl gparted &> ${ERROR_LOG}
  echo -e "\n\t✅  Done\n"
}

function setupGit() {
  echo -e "🖥️  Setting up Git..."
  git config --global core.excludesfile "${DOTFILES_DIR}/assets/global-gitignore"
  git config --global user.email "matt@gauntface.co.uk"
  git config --global user.name "Matt Gaunt"
  echo -e "\n\t✅  Done\n"
}

function installNode() {
  # Install Node and NPM - https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
  echo -e "📦  Installing Node.js..."
  NODE_VERSION=10
  curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | sudo -E bash - &> ${ERROR_LOG}
  sudo apt-get install -y nodejs &> ${ERROR_LOG}
  echo -e "\n\t✅  Done\n"
}

# -e means 'enable interpretation of backslash escapes'
echo -e "\n📓  Installing @gauntface's Dotfiles\n"

initTempDir

installCommonDeps

setupGit

installNode

echo -e "🎉  Finished.\n"