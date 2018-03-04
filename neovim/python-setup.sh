#!/bin/bash
set +e

pip install virtualenvwrapper
source virtualenvwrapper.sh
mkdir -p $VIM_DIR/plugin

mkvirtualenv --python=python3 neovim-py3
workon neovim-py3
pip install neovim jedi psutil setproctitle
echo "let g:python3_host_prog = '$(which python)'" > $VIM_DIR/plugin/neovim-py3.vim

mkvirtualenv --python=python2 neovim-py2
workon neovim-py2
pip install neovim jedi psutil setproctitle
echo "let g:python_host_prog = '$(which python)'" > $VIM_DIR/plugin/neovim-py2.vim
