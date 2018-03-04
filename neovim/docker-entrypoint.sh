#!/bin/bash

if [ -n "${VIRTUAL_ENV}" ]; then
    source virtualenvwrapper.sh
    workon $VIRTUAL_ENV
fi

exec "nvim" "$@"
