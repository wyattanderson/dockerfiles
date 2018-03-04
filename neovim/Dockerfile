FROM ubuntu:xenial as github

RUN apt-get update \
 && apt-get -y install ssh git

ARG GITHUB_SSH_KEY
ARG DOTFILES_BRANCH=master

ADD bitbucket_fingerprint bitbucket_fingerprint
ADD ${GITHUB_SSH_KEY} /root/.ssh/id_rsa

RUN cat bitbucket_fingerprint > /root/.ssh/known_hosts

RUN git clone git@bitbucket.org:wyattanderson/dotfiles.git \
    --branch $DOTFILES_BRANCH

FROM ubuntu:xenial as neovim

ARG USER=ubuntu
ARG UID=1000

RUN apt-get update \
 && apt-get install -y software-properties-common curl apt-transport-https

RUN curl --silent https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
ADD nodesource.list /etc/apt/sources.list.d/nodesource.list

RUN add-apt-repository ppa:neovim-ppa/stable \
 && apt-get update \
 && apt-get install -y neovim python-dev python-pip git locales python3-pip \
                       build-essential nodejs \
 && locale-gen en_US.UTF-8

RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.8.0/ripgrep_0.8.0_amd64.deb \
 && dpkg -i ripgrep_0.8.0_amd64.deb \
 && rm ripgrep_0.8.0_amd64.deb

RUN useradd -u $UID -U -m -s /bin/bash $USER
WORKDIR /home/$USER
COPY --from=github /dotfiles dotfiles
RUN chown -R $USER: dotfiles

USER $USER
ENV USER $USER
ENV HOME /home/$USER
ENV PATH $PATH:$HOME/.local/bin

WORKDIR /home/$USER/dotfiles
ENV VIM_DIR $HOME/.local/share/nvim/site
ADD python-setup.sh python-setup.sh
RUN ./python-setup.sh

RUN make \
 && make neovim \
 && nvim +PlugInstall +:qall

WORKDIR /home/$USER

ENTRYPOINT ["nvim"]
