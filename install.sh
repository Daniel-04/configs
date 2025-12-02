#!/usr/bin/env sh

cp bashrc ~/.bashrc
cp clang-format ~/.clang-format
cp -r doom ~/.config/
cp ghci ~/.ghci
cp gitconfig ~/.gitconfig
cp starship.toml ~/.config/starship.toml

mkdir -p ~/.local/bin
cp scripts/* ~/.local/bin
