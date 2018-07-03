#!/bin/bash

# Catch and log errors
trap uncaughtError ERR

function uncaughtError {
  echo -e "\n\t❌  Error\n"
  if [[ ! -z "${ERROR_LOG}" ]]; then
    echo -e "\t$(<${ERROR_LOG})"
  fi
  echo -e "\n\t😞  Sorry\n"
  exit $?
}

function initTempDir() {
    TEMP_DIR="$(mktemp -d)"
    ERROR_LOG="${TEMP_DIR}/dotfile-install-err.log"
}

function setupDirectories() {
    PROJECTS_DIR="${HOME}/Projects"
    TOOLS_DIR="${HOME}/Projects/Tools"
    CODE_DIR="${HOME}/Projects/Code"
    DOTFILES_DIR="${HOME}/Projects/Tools/dotfiles"

    echo -e "📂  Setting up directories..."
    echo -e "\tProjects:\t${PROJECTS_DIR}"
    echo -e "\tTools:\t\t${TOOLS_DIR}"
    echo -e "\tCode:\t\t${CODE_DIR}"
    echo -e "\tTemp:\t\t${TEMP_DIR}"
    mkdir -p ${PROJECTS_DIR}
    mkdir -p ${TOOLS_DIR}
    mkdir -p ${CODE_DIR}
    echo -e "\n\t✔️  Done\n"
}

function installGit() {
    echo -e "📦  Installing git..."

    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)
            sudo apt-get install -y git curl gparted &> ${ERROR_LOG}
            ;;
        Darwin*)
            # Assume OS X has Git pre-instralled
            # echo "Running on OS X but need to implement install git logic: ${unameOut}" > "$ERROR_LOG"
            # uncaughtError
            # exit 1
            ;;
        *)
            echo "Running on unknown environment: ${unameOut}" > "$ERROR_LOG"
            uncaughtError
            exit 1
            ;;
    esac
    echo -e "\n\t✅  Done\n"
}

function cloneDotfiles() {
    echo -e "🖥  Cloning dotfiles..."
    git clone git@github.com:gauntface/dotfiles.git ${DOTFILES_DIR} &> ${ERROR_LOG}
    (cd $DOTFILES_DIR; git fetch origin) &> ${ERROR_LOG}
    (cd $DOTFILES_DIR; git reset origin/master --hard) &> ${ERROR_LOG}
    echo -e "\n\t✅  Done\n"
}

function runSetup() {
    echo -e "👢 Bootstrap complete...\n"
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)
            bash "${DOTFILES_DIR}/ubuntu-setup.sh"
            ;;
        Darwin*)
            echo "Running on OS X but need to implement setup logic: ${unameOut}" > "$ERROR_LOG"
            uncaughtError
            exit 1
            ;;
        *)
            echo "Running on unknown environment: ${unameOut}" > "$ERROR_LOG"
            uncaughtError
            exit 1
            ;;
    esac
}

# -e means 'enable interpretation of backslash escapes'
echo -e "\n👢  Bootstrapping @gauntface's Dotfiles\n"

initTempDir

setupDirectories

installGit

cloneDotfiles

runSetup
