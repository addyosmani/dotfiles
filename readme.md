# Matt's dotfiles.

This repo contains my personal dotfiles, I've pilfered a few bits from
 [Addy's](https://github.com/addyosmani/dotfiles/) and
 [Mathias's](https://github.com/mathiasbynens/dotfiles/)'s.

## Preinstallation

### Software

- NodeJS
- Nginx
- Chrome Beta
- FF Nightly
- Atom
- GIMP
- Inkscape
- Filezilla

## Installation

It's important to run the right command depending on the platform.

There is specific aliases and set up process for installing default apps and
aliases for each platform - so be warned.

### Ubuntu

```bash
git clone https://github.com/gauntface/dotfiles.git && cd dotfiles && sh ubuntu-setup.sh
```

**You will probably need to reboot** to make ZSH take control of your terminal.

Next the list of stuff to do:

* SSH on github.
* Setup Atom and Sublime with the plugins you love.
* Add the ability to preview images from NAS: Nautilus -> Edit-> Preferences-> Preview

### OS X

```bash
git clone https://github.com/gauntface/dotfiles.git && cd dotfiles && sh ...-setup.sh
```
