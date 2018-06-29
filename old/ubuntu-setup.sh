# Add Nginx Repo
# sudo add-apt-repository ppa:nginx/stable -y

# Add Chrome Repo
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Perform repo update
# sudo apt-get update
# Install Applications
# sudo apt-get install nginx curl git zsh xclip synaptic ruby openjdk-8-jdk openjdk-8-jre google-chrome-stable google-chrome-beta google-chrome-unstable gparted gscan2pdf -y

# Install Oh My Zsh
curl -L http://install.ohmyz.sh | sh

# Try and fix: https://github.com/robbyrussell/oh-my-zsh/issues/1224
chsh -s $(which zsh)

cp ohmyzsh/zshrc ~/.zshrc

# Install gcloud
# if [ -d "~/Projects/Tools/google-cloud-sdk/" ]; then
#  curl https://sdk.cloud.google.com | bash
# fi

cp npmrc ~/.npmrc

cat aliases ubuntu-aliases > ~/.aliases

# Make common project directory structure
#mkdir -p ~/Projects
#mkdir -p ~/Projects/Code
#mkdir -p ~/Projects/Sites
#mkdir -p ~/Projects/Tools
#mkdir -p ~/Projects/Tools/Configs
#mkdir -p ~/Projects/Designs
#mkdir -p ~/Projects/Slides

# Set up config files for eslint
#cp eslintrc ~/Projects/Tools/Configs/eslintrc

# Set up git global values
#cp gitignore ~/.gitignore_global
#git config --global core.excludesfile '~/.gitignore_global'
#git config --global user.email "matt@gauntface.co.uk"
#git config --global user.name "Matt Gaunt"

# Install NPM - https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
#curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
#sudo apt-get install -y nodejs

# Set up npm for global install without sudo
mkdir "${HOME}/.npm-packages"

# Set up npm for global install without sudo
# mkdir "${HOME}/.python-packages"

# Install commonly used npm deps
# npm install -g gulp eslint forever nodemon
