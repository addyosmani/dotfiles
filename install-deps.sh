#!/bin/bash

# up to you (me) if you want to run this as a file or copy paste at your leisure


# https://github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
sudo bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)

# https://rvm.io
# rvm for the rubiess
curl -L https://get.rvm.io | bash -s stable --ruby

# https://github.com/isaacs/nave
# needs npm, obviously.
# TODO: I think i'd rather curl down the nave.sh, symlink it into /bin and use that for initial node install.
npm install -g nave


# homebrew!
# you need the code CLI tools YOU FOOL.
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

# https://github.com/rupa/z
# z, oh how i love you
mkdir -p ~/dotfiles/z
curl https://raw.github.com/rupa/z/master/z.sh > ~/dotfiles/z/z.sh
chmod +x ~/dotfiles/z/z.sh

# add this to the bash_profile file if it aint there.
#   . ~/code/z/z.sh

# commonly used npm deps
sudo npm install -g yo gulp grunt-cli jshint browserify generator-webapp generator-gulp-webapp forever nodemon

# chrome canary as default
# on a mac you can set chrome canary as your default inside of Safari preferences :)
