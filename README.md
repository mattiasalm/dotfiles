# dotfiles

Automated macOS setup for Apple Silicon Macs with a CLI to manage installation and updates.

## Prerequisites

**Required:**
- Apple Silicon Mac (M1, M2, M3, or later)
- macOS Ventura (13.0) or later
- Internet connection
- Admin privileges (you'll be prompted for password)

**Recommended:**
- Fresh macOS installation for best results
- Backup of existing data
- ~2-3 hours for complete setup

⚠️ **Warning**: This will modify system settings and install numerous applications. Use at your own risk.

## About This Setup

This is my **personal** dotfiles configuration, tailored for my specific workflow and preferences. It includes:

- **Personal preferences**: Interactive language selection (Swedish/English), specific app choices, custom shortcuts
- **Development focus**: Web development tools, Docker, Node.js ecosystem
- **Opinionated choices**: Specific terminal setup, window management, productivity apps

**For your own use:**
- **Fork this repository** and customize it to your needs
- Review the [Brewfile](./applications/Brewfile) and modify app selections
- Adjust macOS settings in `/macos-settings/` to match your preferences
- Update personal information in `/macos-settings/general.sh` (language, timezone)

**License**: MIT - Feel free to use, modify, and redistribute. See what works for you and make it your own!

## What Gets Installed

**Package Managers:**
- [Homebrew](https://brew.sh) - macOS package manager
- [n](https://github.com/tj/n) - Node.js version manager

**Development Tools:**
- Node.js LTS + npm + Yarn + Bun
- PostgreSQL 16 + OpenJDK 21
- Docker + Git tools
- Visual Studio Code + extensions

**Applications:** (50+ apps including)
- Productivity: 1Password, Alfred, Slack, Microsoft Office
- Development: Docker, Postman, Fork, Hyper terminal  
- Creative: Adobe Creative Cloud, Figma
- Utilities: Hammerspoon, Stats, Dropbox

**macOS Configuration:**
- System preferences (Dock, Finder, Trackpad, etc.)
- Shell configuration with Starship prompt + Cousine Nerd Font
- Application settings sync via Mackup

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

3. Run the main setup (includes interactive prompts):
	```bash
	dotfiles all
	```
	You'll be prompted to:
	- Enter your computer name
	- Select your preferred language (Swedish/English/Other)

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

## Post-Installation Setup

After the automated setup completes, these manual steps are required:

### 1. Application Settings Sync
1. **Sign in to Dropbox** (if you use it for settings backup)
2. **Run Mackup restore**: `mackup restore`
3. This will restore your previous app configurations and settings

### 2. System Permissions
1. **Launch Hammerspoon** and grant Accessibility permissions when prompted
2. **Configure Focus/Do Not Disturb** settings in System Preferences if desired
3. **Review Privacy & Security** settings for newly installed apps

### 3. Development Setup
1. **Generate SSH keys** for GitHub/GitLab:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ssh-add --apple-use-keychain ~/.ssh/id_ed25519
   ```
2. **Add SSH key to GitHub**: [GitHub SSH instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
3. **Configure Git globally**:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your_email@example.com"
   ```

### 4. Multiple SSH Keys (Optional)
If you need multiple SSH keys for different services, create `~/.ssh/config`:

```bash
# Work account
Host work.github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_work

# Personal account  
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
```

Verify all keys are loaded: `ssh-add -l`

## Troubleshooting

### Common Issues

**Installation fails during software updates:**
- Reboot and run `dotfiles prepare` again
- Updates may require multiple reboots

**Homebrew permission errors:**
- Run: `sudo chown -R $(whoami) /opt/homebrew`
- Then retry the installation

**Applications not launching:**
- Some apps may need manual first launch from Applications folder
- Check System Preferences > Privacy & Security for blocked apps

**Hammerspoon not working:**
- Ensure Accessibility permissions are granted
- Restart Hammerspoon after granting permissions

### Getting Help

1. Check the [Issues page](https://github.com/mattiasalm/dotfiles/issues) for known problems
2. Run `dotfiles help` for available commands
3. For Homebrew issues: `brew doctor`

## Customization

This setup reflects my personal preferences. To make it yours:

### Essential Customizations
1. **Language & Region**: Now interactive during setup! Or edit `/macos-settings/general.sh` for more languages
2. **Applications**: Modify `/applications/Brewfile` to add/remove apps you want
3. **macOS Settings**: Review scripts in `/macos-settings/` and adjust system preferences
4. **Git Configuration**: Update your name/email in post-installation steps

### Optional Customizations
- **Aliases**: Add your preferred shortcuts to `/system/.alias`
- **Starship Prompt**: Customize the prompt in `/config/starship.toml`
- **VS Code**: Modify the extension list in the Brewfile `vscode` entries
- **Hammerspoon**: Add your window management scripts to the config

### Fork and Modify
1. Fork this repository to your GitHub account
2. Clone your fork: `git clone https://github.com/yourusername/dotfiles.git`
3. Make your changes and commit them
4. Use your fork's URL in the installation command

## License

MIT License - You're free to use, modify, and distribute this code. No warranty provided.

**Inspiration**: This setup is inspired by the macOS dotfiles community. Make it your own!