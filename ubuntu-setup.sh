#!/bin/bash

# Catch and log errors
trap uncaughtError ERR
function uncaughtError {
  echo -e "\n\t❌  Error\n"
  echo "$(<${ERROR_LOG})"
  echo -e "\n\t😞  Sorry\n"
  exit $?
}

function initDirectories() {
  PROJECTS_DIR="${HOME}/Projects"
  TOOLS_DIR="${HOME}/Projects/Tools"
  CODE_DIR="${HOME}/Projects/Code"
  DOTFILES_DIR="${HOME}/Projects/Tools/dotfiles"
  TEMP_DIR="$(mktemp -d)"
  ERROR_LOG="${TEMP_DIR}/dotfile-install-err.log"
}

function installCommonDeps() {
  echo -e "📦  Installing common dependencies..."
  sudo apt-get install -y curl gparted zsh &> ${ERROR_LOG}
  echo -e "\n\t✅  Done\n"
}

function setupGit() {
  echo -e "🖥️  Setting up Git..."
  git config --global core.excludesfile "${DOTFILES_DIR}/assets/global-gitignore"
  git config --global user.email "mattgaunt@google.com"
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

function setupNPM() {
  echo -e "️️🖥️  Setting up NPM..."
  curl -sL https://raw.githubusercontent.com/glenpike/npm-g_nosudo/master/npm-g-nosudo.sh | sh - &> ${ERROR_LOG}
  echo -e "\n\t✅  Done\n"
}

function installZSH() {
  echo -e "📦  Installing oh-my-zsh..."
  curl -sL "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh" | sudo -E zsh - &> ${ERROR_LOG}
  echo -e "\n\t✅  Done\n"
}

function setupZSHRC() {
  echo -e "👻  Symlinking .zshrc..."
  ZSH_FILE="${HOME}/.zshrc"
  
  if [ -L "${ZSH_FILE}" ] || [ -f "${ZSH_FILE}" ] ; then
    sudo rm "${ZSH_FILE}"
  fi

  echo -e "source ${DOTFILES_DIR}/assets/zshrc" > "${ZSH_FILE}"
  echo -e "\n\t✅  Done\n"
}

function switchToZSH() {
  echo -e "🚧  Switching to ZSH..."
  chsh -s $(which zsh) &> ${ERROR_LOG}
  echo -e "\n\t✅  Done\n"
}

# -e means 'enable interpretation of backslash escapes'
echo -e "\n📓  Installing @gauntface's Dotfiles\n"

initDirectories

installCommonDeps

setupGit

installNode

setupNPM

installZSH

setupZSHRC

echo -e "🎉  Finished.\n"