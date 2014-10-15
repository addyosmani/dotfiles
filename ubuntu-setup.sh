# Add Atom.io Repo
sudo add-apt-repository ppa:webupd8team/atom -y

# Add Nginx Repo
sudo add-apt-repository ppa:nginx/stable -y

# Perform repo update
sudo apt-get update
# Install Applications
sudo apt-get install atom nginx curl git zsh xclip synaptic ruby -y

# Install Oh My Zsh
curl -L http://install.ohmyz.sh | sh

# Try and fix: https://github.com/robbyrussell/oh-my-zsh/issues/1224
chsh -s $(which zsh)

cp ohmyzsh/zshrc ~/.zshrc

cat aliases ubuntu-aliases > ~/.aliases

# Make common project directory structure
mkdir -p ~/Projects
mkdir -p ~/Projects/Code
mkdir -p ~/Projects/Sites
mkdir -p ~/Projects/Tools
mkdir -p ~/Projects/Tools/Configs
mkdir -p ~/Projects/Designs

# Set up config files for jshint and jscs
cp jscsrc ~/Projects/Tools/Configs/jscsrc
cp jshintrc ~/Projects/Tools/Configs/jshintrc

# Set up git global values
cp gitignore ~/.gitignore_global
git config --global core.excludesfile '~/.gitignore_global'
git config --global user.email "matt@gauntface.co.uk"
git config --global user.name "Matt Gaunt"

# Install NPM
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs

# Install commonly used npm deps
sudo npm install -g gulp grunt-cli jshint yo generator-webapp generator-gulp-webapp forever nodemon trash
