# Project Context

## Purpose
Personal dotfiles repository for managing development environment configuration across macOS and Linux systems. Uses GNU Stow for symlink management to maintain consistent terminal, editor, and shell configurations.

## Tech Stack
- **Shell**: Zsh with Oh My Zsh framework
- **Terminal Emulators**: Alacritty, WezTerm
- **Editor**: Neovim (v0.11.2+) with Lua configuration
- **Multiplexer**: tmux
- **CLI Tools**: k9s (Kubernetes), lazygit, fzf, fasd
- **Package Management**: GNU Stow for dotfile deployment
- **Install Tools**: apt (Linux), Homebrew (macOS), wget

## Project Conventions

### Code Style
- **Shell Scripts**: Bash for installation/setup scripts with explicit error handling
- **Neovim Config**: Lua-based configuration (modern Neovim standard)
- **Naming**: Lowercase with hyphens for directories, snake_case for shell variables
- **Indentation**: 2 spaces for shell scripts and configs

### Architecture Patterns
- **Stow-based deployment**: Each application has its own directory containing `.config` or dotfiles
- **Installation script**: Single `install.sh` handles dependencies, clones plugins, and stow deployment
- **Version pinning**: External plugins/tools use specific version tags for reproducibility
- **Cross-platform support**: OS detection in scripts (Darwin/Linux) for platform-specific paths

### Testing Strategy
- Manual testing on target Linux and macOS environments
- Installation scripts use `command -v` for dependency checking before installation

### Git Workflow
- Direct commits to main branch (personal repo)
- Conventional commits preferred but not enforced
- Changes tested locally before pushing

## Domain Context
This is a **personal configuration repository** for a developer who works with:
- Kubernetes (k9s configuration included)
- Node.js development (NVM integration in zshrc)
- Git workflows (lazygit, git plugins)
- Terminal-based development workflow

The repository prioritizes:
- Reproducible environment setup on fresh machines
- Minimal manual intervention during installation
- Performance (specific plugin versions, fasd for fast directory jumping)

## Important Constraints
- Must support both macOS (Darwin) and Linux
- Configurations should not break when stowed over existing files
- Plugin versions are pinned for stability
- Installation must work in unattended mode (e.g., Oh My Zsh `--unattended` flag)
- Neovim AppImage requires x86_64 Linux architecture

## External Dependencies
- **Oh My Zsh**: Framework loaded from GitHub, installed via curl
- **Zsh Plugins**: 
  - zsh-autosuggestions (v0.7.0)
  - zsh-syntax-highlighting (0.8.0)
  - zsh-you-should-use (1.9.0)
- **CLI Tools from GitHub**:
  - fzf (v0.55.0)
  - fasd (1.0.1)
  - lazygit (v0.53.0)
  - Neovim (v0.11.2)
- **NVM**: Node Version Manager (path varies by OS/install method)
- **GNU Stow**: Required for symlink deployment
