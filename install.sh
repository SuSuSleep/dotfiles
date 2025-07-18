#!/bin/bash

if ! command -v zsh &>/dev/null; then
  echo "Installing zsh..."
  if command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y zsh stow
  elif command -v brew &>/dev/null; then
    brew install zsh stow make cmake
  else
    echo "Error: Could not detect package manager to install zsh"
    exit 1
  fi
else
  echo "zsh is already installed"
fi

# install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ] || [ -z "$(ls -A $HOME/.oh-my-zsh)" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh is already installed"
fi

stow -t $HOME k9s
stow -t $HOME nvim
stow -t $HOME tmux
stow -t $HOME wezterm
# Overlap it
rm ~/.zshrc
stow -t $HOME zsh

# install zsh plugin
zsh_plugin_root="$HOME/.oh-my-zsh/custom/plugins"

# zsh-autosuggestions
tag=v0.7.0
git clone --quiet -b $tag https://github.com/zsh-users/zsh-autosuggestions.git $zsh_plugin_root/zsh-autosuggestions

# zsh-syntax-highlighting
tag=0.8.0
git clone --quiet -b $tag https://github.com/zsh-users/zsh-syntax-highlighting.git $zsh_plugin_root/zsh-syntax-highlighting

# zsh-you-should-use
tag=1.9.0
git clone --quiet -b $tag https://github.com/MichaelAquilina/zsh-you-should-use.git $zsh_plugin_root/zsh-you-should-use

# fzf
tag=v0.55.0
git clone --quiet -b $tag https://github.com/junegunn/fzf.git $zsh_plugin_root/fzf
$zsh_plugin_root/fzf/install --all

# fasd
tag=1.0.1
git clone --quiet -b $tag https://github.com/clvv/fasd.git $zsh_plugin_root/fasd
cd $zsh_plugin_root/fasd
PREFIX=$HOME make install

# reload zshrc
source ~/.zshrc

mkdir -p ~/.local/bin
# install nvim
wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage ~/.local/bin/nvim
# install lazygit
wget https://github.com/jesseduffield/lazygit/releases/download/v0.53.0/lazygit_0.53.0_Linux_x86_64.tar.gz
tar zxvf lazygit_0.53.0_Linux_x86_64.tar.gz lazygit
mv lazygit ~/.local/bin/lazygit
