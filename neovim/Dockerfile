FROM ubuntu:xenial

RUN apt-get update \
 && apt-get install -y software-properties-common \
 && add-apt-repository ppa:neovim-ppa/stable \
 && apt-get update \
 && apt-get install -y neovim python-dev python-pip curl git

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

CMD ["nvim"]
