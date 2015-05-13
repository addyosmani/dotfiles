# Install Oh My Zsh
curl -L http://install.ohmyz.sh | sh

cp ohmyzsh/zshrc ~/.zshrc
cp npmrc ~/.npmrc

cat aliases mac-aliases > ~/.aliases

# Make common project directory structure
mkdir -p ~/Projects
mkdir -p ~/Projects/Code
mkdir -p ~/Projects/Sites
mkdir -p ~/Projects/Tools
mkdir -p ~/Projects/Tools/Configs
mkdir -p ~/Projects/Designs
mkdir -p ~/Projects/Slides

# Set up config files for jshint and jscs
cp jscsrc ~/Projects/Tools/Configs/jscsrc
cp jshintrc ~/Projects/Tools/Configs/jshintrc

# Set up git global values
cp gitignore ~/.gitignore_global
git config --global core.excludesfile '~/.gitignore_global'
git config --global user.email "matt@gauntface.co.uk"
git config --global user.name "Matt Gaunt"

# Install commonly used npm deps
npm install -g gulp grunt-cli jshint yo generator-webapp generator-gulp-webapp forever nodemon trash
