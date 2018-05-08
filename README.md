**so you fucked up your computer** - spilled one too many glasses of kombucha onto it, dropped it down the stairs trying to carry it with two fingers, whatever - doesn't matter.

this script is going to:

- install your shit 
	- chrome
	- spotify
	- slack
	- docker
	- sublime
	- zshell
	- redis
	- postgres
	- etc
- configure your shit 
	- sublime text settings
	- some osx settings
	- zshell
	- rbenv
	- pyenv
	- git
	- etc

**first thing you do with this computer** (don't even install chrome, dude):

- `git clone https://github.com/heyalexchoi/osx.git && cd osx && sh install.sh`
- wait. watch the script - some things may break - brew formulas change and stuff - the script doesn't do much to catch any of that. fix the script as you go. copy `~/.zshrc` or `.gitconfig` back into here if you change them.

# good job!

![good job](https://media.giphy.com/media/l0HlyiU60rxnEWady/giphy.gif)

## Setting up new laptop

1. Install XCode command line tools ([https://developer.apple.com/downloads/](https://developer.apple.com/downloads/), "Sign In" required)
1. Run `sudo chown -R $USER /usr/local`
1. Run install.sh (see below)
1. Run installers that need to be finished separately (uTorrent, Hearthstone, etc.)
1. Run OS X customization file (aka Mathias .osx, see below)
1. Update OS X and apps (through App Store)
1. Map Caps to Ctrl in keyboard settings (since this is apparently quite difficult to do programmatically http://apple.stackexchange.com/questions/13598/updating-modifier-key-mappings-through-defaults-command-tool)
1. Add translit as an input source in System Prefs (+ map it to Alt+Cmd+Space)
1. Set Quicksilver triggers
1. Customize iTerm settings ("quit when all windows are closed", "preserve window positions", etc.; should this be automated?)
1. Install Fleep through App Store (since there's no casks for them... yet)
1. Install messenger from https://fbmacmessenger.rsms.me/


## install.sh

This is the main script that installs 90%+ of things required to get a "working" OS X. It's meant to be run as part of a fresh install on a new laptop.

In a nutshell, it does this:

- Installs all the brews that I use (git, zsh, cairo, node, postgresql, etc.)
- Installs all the applications that I use, via cask (chrome, quicksilver, imageoptim, virtualbox, etc.)
- Installs oh-my-zsh and sets it up
- Generates SSH keys (and opens github settings page for convenience)
- Installs global node packages that I use often (bower, jshint, jscs, etc.)
- Customizes Sublime using other files from this repo
- Installs translit keyboard

## defaults.sh

Sets up sensible OS X defaults and other useful tweaks. Based on Mathias' excellent .osx

## Package Control.sublime-settings

Specifies which Sublime packages to install

## Preferences.sublime-settings

Specifies main Sublime settings

## .oh-my-zsh-custom

Defines custom functions and alises for oh-my-zsh

## Inspired by / shamelessly stolen from these fine folks

- [Hacker's Guide to Setting Up Your Mac](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac)
- [Thoughtbot's laptop setup](https://github.com/thoughtbot/laptop/blob/master/mac)
- [Hakunin's dotfiles](https://github.com/maxim/dotfiles)
- [Mathias' .osx](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)

## Something similar (found later)

- [Miller Medeiros' Setup Mac OS X Mountain Lion or Mavericks](https://gist.github.com/millermedeiros/6615994)
