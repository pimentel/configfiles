# Harold Pimentel's configuration files

The way this is set up is using GNU stow.
Each folder is a stow module.
Here's how you install them:

```
stow main
```

# installing the core

First, install Homebrew.
This is distributed via a Homebrew bundle.
Use this command to install:

```
brew bundle
```

# zsh

The main shell is `zsh`.
Right now I am using [`slimzsh`](https://github.com/changs/slimzsh).
Installation is done as follows:

```
git clone --recursive https://github.com/changs/slimzsh.git ~/.slimzsh
```

# vim

Make sure MacVim is installed via Homebrew.
Then, make sure you install `vim-plug`.
Startup vim, then run:

```
:PlugInstall
```

NOTE: this is all currently being redone so it is very incomplete
