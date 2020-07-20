#!/bin/sh

### Installing Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

### Install Airline using pathogen
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline

### Install Airline Theme
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes

### Install NERDTree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

### Installing emmet
git clone https://github.com/mattn/emmet-vim.git ~/.vim/bundle

### Configure .vimrc
mv  ~/.vimrc ~/.vimrc.old
cp .vimrc ~/.vimrc
