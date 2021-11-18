# dotfiles

My version of dotfiles with a CLI to manage installation process and updates.

## Features

Very easy installation that brings a brand new installation of macOS up to full setup with just a few commands.

Uses:

- [Homebrew](https://brew.sh) Package management
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask)
- [Node.js + npm LTS](https://nodejs.org/en/download/)
- [Mackup](https://github.com/lra/mackup) sync application settings
- [n](https://github.com/tj/n) Node.js and npm version management

## Installation

1. Install the CLI with `curl`

	```bash
	curl -Ls "https://raw.githubusercontent.com/mattiasalm/dotfiles/master/remote-install.sh" | bash
	```

2. Run software update and install Xcode with command:
	```bash
	dotfiles prepare
	```
	It may cause system to reboot.

## Setup of system with `dotfiles` command

```bash
$ dotfiles
Usage: dotfiles <command>

Commands:
  help                  - Show this help message
  all                   - Do all installation steps
  macos-settings        - Applies macOS settings
  prepare               - Prepare system for further installation
  managers              - Install application managers
  applications          - Install applications
  update                - Update system, managers and applications
```

To do a full setup of the system just run the `dotfiles all` command.

Note: When setup is finished; sign in to Dropbox and then run `mackup restore` to bring back app configurations.