#!/bin/bash

stow -t $HOME k9s
stow -t $HOME nvim
stow -t $HOME tmux
stow -t $HOME wezterm
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
git clone --quiet -b $tag https://github.com/junegunn/fzf.git $$zsh_plugin_root/fzf
$zsh_plugin_root/fzf/install --all

# fasd
tag=1.0.1
git clone --quiet -b $tag https://github.com/clvv/fasd.git $zsh_plugin_root/fasd
cd $zsh_plugin_root/fasd
PREFIX=$HOME make install
