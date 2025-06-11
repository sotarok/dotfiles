# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing system configurations across multiple platforms (macOS, Debian, CentOS). It contains shell configurations, editor settings, development tools, and automation scripts.

## Common Commands

### Initial Setup
```bash
# Main setup script (creates symlinks and installs dependencies)
./misc/setup.sh /path/to/dotfiles

# Platform-specific setup
./misc/mac_setup.sh      # macOS
./misc/debian_setup.sh   # Debian/Ubuntu
./misc/setup_with_centos.sh  # CentOS
```

### Development Environment Setup
```bash
# Language version managers
./misc/nvm_setup.sh      # Node.js
./misc/rvm_setup.sh      # Ruby
./misc/phpenv_setup.sh   # PHP
./misc/python26.sh       # Python 2.6
./misc/python27.sh       # Python 2.7

# Services
./misc/mongodb_setup.sh  # MongoDB
./misc/postfix_setup.sh  # Postfix
```

## Key Architecture

### Directory Structure
- **Shell Configurations**: `/zsh/` contains Zsh configuration with modular setup in `.zshrc.d/`
- **Editor Settings**: `/vim/` uses Vundle for plugin management, extensive `.vimrc` configuration
- **Symlink-Based**: All dotfiles are symlinked from this repository to `$HOME` via `setup.sh`
- **Custom Scripts**: `/bin/` contains utility scripts that get linked to `~/bin`

### Configuration Management
- Uses `zplug` for Zsh plugin management
- Uses `anyenv` as a unified version manager for multiple languages
- Git submodules for external dependencies (e.g., autojump)
- Ansible playbooks in `/ansible/` for infrastructure automation
- Vagrant configurations in `/vagrant/` for development VMs

### Platform Detection
The setup scripts detect the platform and apply appropriate configurations:
- macOS: Installs Homebrew, sets keyboard repeat rates, runs Vim bundle install
- Linux: Different setup scripts for Debian and CentOS distributions

## Important Notes
- SSH keys in `/ssh/` are managed carefully - `setup.sh` merges authorized_keys
- The repository expects to be cloned to a stable location as it uses absolute symlinks
- When modifying shell configurations, changes take effect after restarting the shell or sourcing `.zshrc`