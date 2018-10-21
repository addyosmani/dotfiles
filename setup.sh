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
  
  echo -e "📂  Setting up directories..."
  echo -e "\tProjects:\t${PROJECTS_DIR}"
  echo -e "\tTools:\t\t${TOOLS_DIR}"
  echo -e "\tCode:\t\t${CODE_DIR}"
  echo -e "\tDotfiles:\t\t${DOTFILES_DIR}"
  echo -e "\tTemp:\t\t${TEMP_DIR}"
  echo -e "\n\t✔️  Done\n"
}

function installCommonDeps() {
  echo -e "📦  Installing common dependencies..."
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)
          sudo apt-get install -y curl gparted zsh synaptic &> ${ERROR_LOG}
          ;;
      Darwin*)
          # NOOP
          ;;
      *)
          # NOOP
          ;;
  esac
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
  if ! [ -x "$(command -v node)" ]; then
    NODE_VERSION=10
    curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | sudo bash - &> ${ERROR_LOG}
    sudo apt-get install -y nodejs &> ${ERROR_LOG}
  fi
  echo -e "\n\t✅  Done\n"
}

function setupNPM() {
  echo -e "️️🖥️  Setting up NPM..."
  curl -sL https://raw.githubusercontent.com/glenpike/npm-g_nosudo/master/npm-g-nosudo.sh | sh - &> ${ERROR_LOG}
  echo -e "\n\t✅  Done\n"
}

function installZSH() {
  if [[ "${SHELL}" = "/usr/bin/zsh" ]]; then
    return
  fi

  echo -e "📦  Installing oh-my-zsh..."
  curl -sL "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh" | zsh - &> ${ERROR_LOG}
  echo -e "\n\t✅  Done\n"
}

function setupZSHRC() {
  echo -e "👻  Setting up .zshrc..."
  ZSH_FILE="${HOME}/.zshrc"

  if [ -L "${ZSH_FILE}" ] || [ -f "${ZSH_FILE}" ] ; then
    rm "${ZSH_FILE}" &> ${ERROR_LOG}
  fi

  echo -e "source ${DOTFILES_DIR}/assets/zshrc" > "${ZSH_FILE}"
  echo -e "\n\t✅  Done\n"
}

function switchToZSH() {
  if [[ "${SHELL}" = "/usr/bin/zsh" ]]; then
    return
  fi

  echo -e "🚧  Switching to ZSH..."
  # Changing shell requires user input.
  chsh -s $(which zsh)
  echo -e "\n\t✅  Done\n"
}

function installStockGnome() {
  if [[ "${IS_CORP_INSTALL}" = true ]]; then
    return
  fi
  
  echo -e "📦  Installing stock Gnome..."
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)
          # This can display an interactive screen.
          sudo apt-get install -y gnome-session vanilla-gnome-default-settings &> ${ERROR_LOG}
          # Change the login to gnome-shell
          sudo update-alternatives --config gdm3.css
          ;;
      Darwin*)
          # NOOP
          ;;
      *)
          # NOOP
          ;;
  esac
  echo -e "\n\t✅  Done\n"
}

function installChrome() {
  if [[ "${IS_CORP_INSTALL}" = true ]]; then
    return
  fi
  
  echo -e "🌎  Installing Chrome..."
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)
          if [ ! -f /etc/apt/sources.list.d/google.list ]; then
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &> ${ERROR_LOG}

	    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' &> ${ERROR_LOG}
	  fi
          sudo apt-get update &> ${ERROR_LOG}
          sudo apt-get install -y google-chrome-stable &> ${ERROR_LOG}
          ;;
      Darwin*)
          # NOOP
          ;;
      *)
          # NOOP
          ;;
  esac
  echo -e "\n\t✅  Done\n"
}

function installVSCode() {
  if [[ "${IS_CORP_INSTALL}" = true ]]; then
    return
  fi
  
  echo -e "📝  Installing VSCode..."
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)
          if [ ! -f /etc/apt/sources.list.d/vscode.list ]; then
            curl --silent https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg &> ${ERROR_LOG}
            sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/  &> ${ERROR_LOG}
            rm microsoft.gpg &> ${ERROR_LOG}

	    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' &> ${ERROR_LOG}
	  fi
          sudo apt-get update &> ${ERROR_LOG}
          sudo apt-get install -y code &> ${ERROR_LOG}
          ;;
      Darwin*)
          # NOOP
          ;;
      *)
          # NOOP
          ;;
  esac
  echo -e "\n\t✅  Done\n"
}

function setupCorpSpecific() {
  if [[ "${IS_CORP_INSTALL}" = false ]]; then
    return
  fi

  echo "💼  Would you like to set up corp specific dotfiles?  (Please enter a number)"
  select yn in "Yes" "No"; do
      case $yn in
          Yes )
              getCorpCommand
              break;;
          No )
              break;;
      esac
  done
  echo ""
}

function getCorpCommand() {
  echo ""
  read -p "Please enter the command from http://go/user.git/mattgaunt/dotfiles : " CORP_COMMAND
  echo -e "\nDoes this look right? (Please enter a number)"
  echo -e "\n\t${CORP_COMMAND}\n"
  select yn in "Yes" "No (Retry)" "No (Skip)"; do
      case $yn in
          Yes )
              echo ""
              eval $CORP_COMMAND
              break;;
          "No (Retry)" )
              getCorpCommand
              break;;
          "No (Skip)" )
              break;;
      esac
  done
  echo ""
}

# -e means 'enable interpretation of backslash escapes'
echo -e "\n📓  Installing @gauntface's Dotfiles\n"

initDirectories

installCommonDeps

setupGit

installNode

installZSH

setupZSHRC

switchToZSH

# Setup NPM *after* ZSH to ensure it's configured for ZSH correctly
setupNPM

installStockGnome

installChrome

installVSCode

setupCorpSpecific

echo -e "🎉  Finished, reboot to complete.\n"
