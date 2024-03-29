# dotfiles

My version of dotfiles with a CLI to manage installation process and updates.

Tested on macOS: Big Sur and Monterey.

Take and use at your own risk.

## Features

Very easy installation that brings a brand new installation of macOS up to full setup with just a few commands.

Uses:

- [Homebrew](https://brew.sh) - packages [Brewfile](./applications/Brewfile)
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask) - packages [Brewfile](./applications/Caskfile)
- [n](https://github.com/tj/n) - Node.js and npm version management
- [Node.js + npm LTS](https://nodejs.org/en/download/)
- [Mackup](https://github.com/lra/mackup) - sync application settings
- [Hammerspoon](https://www.hammerspoon.org/) - Window management and MacOS automation

## Installation

1. Install the CLI with `curl`

	```bash
	curl -Ls "https://raw.githubusercontent.com/mattiasalm/dotfiles/master/remote-install.sh" | zsh
	```

2. Run software update and install Xcode with command:
	```bash
	dotfiles prepare
	```
	It may cause system to reboot.

## Setup of system with `dotfiles` command

```
$ dotfiles
Usage: dotfiles <command>

Commands:
  help                  - Show this help message
  prepare               - Prepare system for further installation
  all                   - Run all installation steps
  managers              - Install application managers
  applications          - Install applications
  macos-settings        - Applies macOS settings
  configuration         - Add system configuration
  update                - Update system, managers and applications
```

To do a full setup of the system just run the `dotfiles all` command.

## Manual setup steps

Some manual steps are required after the automatic setup is finished. 

### Mackup

When the setup is finished sign in to Dropbox and then run `mackup restore` to bring back app configurations.

### Hammerspoon

Run Hammerspoon and activate accessibility to ensure full functionality.

### SSH keys

Update SSH keys in all places needed, such as GitHub. [GitHub SSH key instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

If support for multiple SSH keys is needed, adjust the `~/.ssh/config` file with the needed information. Example of `config` file:

```bash
# Work bitbucket
Host bitbucket.org
IdentityFile ~/.ssh/id_rsa

# Anything else = github
Host *
IdentityFile ~/.ssh/id_ed25519
```

Just make sure that all SSH keys is listed in the SSH agent by typing 

```bash
$ ssh-add -l
```