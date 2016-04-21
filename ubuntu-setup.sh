# Add Atom.io Repo
sudo add-apt-repository ppa:webupd8team/atom -y

# Add Nginx Repo
sudo add-apt-repository ppa:nginx/stable -y

# Perform repo update
sudo apt-get update
# Install Applications
sudo apt-get install atom nginx curl git zsh xclip synaptic ruby openjdk-7-jdk openjdk-7-jre -y

# Install Oh My Zsh
curl -L http://install.ohmyz.sh | sh

# Try and fix: https://github.com/robbyrussell/oh-my-zsh/issues/1224
chsh -s $(which zsh)

cp ohmyzsh/zshrc ~/.zshrc
cp npmrc ~/.npmrc

cat aliases ubuntu-aliases > ~/.aliases

# Make common project directory structure
mkdir -p ~/Projects
mkdir -p ~/Projects/Code
mkdir -p ~/Projects/Sites
mkdir -p ~/Projects/Tools
mkdir -p ~/Projects/Tools/Configs
mkdir -p ~/Projects/Designs
mkdir -p ~/Projects/Slides

# Set up config files for eslint
cp eslintrc ~/Projects/Tools/Configs/eslintrc

# Set up git global values
cp gitignore ~/.gitignore_global
git config --global core.excludesfile '~/.gitignore_global'
git config --global user.email "matt@gauntface.co.uk"
git config --global user.name "Matt Gaunt"

# Install NPM
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y nodejs

# Set up npm for global install without sudo
mkdir "${HOME}/.npm-packages"

# Set up npm for global install without sudo
mkdir "${HOME}/.python-packages"

# Install commonly used npm deps
npm install -g gulp eslint forever nodemon trash

# Install commonly used atom plugins
apm install linter linter-eslint docblockr
