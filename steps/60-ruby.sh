#!/bin/bash -eu

# install chruby
if ! [ -f ~/.bashrc.d/chruby ]; then
    pushd /tmp
        rm -rf chruby-0.3.9
        wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
        tar -xzvf chruby-0.3.9.tar.gz
        cd chruby-0.3.9/
        sudo make install
    popd
fi
>~/.bashrc.d/chruby echo "source /usr/local/share/chruby/chruby.sh"

# install ruby-install
if ! >/dev/null which ruby-install; then
    pushd /tmp
        rm -rf ruby-install-0.8.3
        wget -O ruby-install-0.8.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.8.3.tar.gz
        tar -xzvf ruby-install-0.8.3.tar.gz
        cd ruby-install-0.8.3/
        sudo make install
    popd
fi

# install ruby 3
if ! [ -e ~/.rubies/ruby-3.1.2 ]; then
    ruby-install ruby 3.1.2
fi