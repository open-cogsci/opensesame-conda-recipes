#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
    if [[ -z "$(which brew)" ]]; then
        echo "Sorry, OSX requires a homebrew installation!"
        exit 1
    fi
    brew install jpeg libpng freetype
    brew install sdl sdl_gfx sdl_image sdl_mixer sdl_net sdl_ttf 
    brew install portmidi smpeg
elif [[ "$(uname)" == "Linux" ]]; then
    if [[ -z "$(which apt-get)" ]]; then
        echo "** warning: Can only check dependencies on ubuntu/debian"
    else
        echo "Checking dependencies..."
        declare -a packages=("libav-tools" "libsdl-image1.2-dev" "libsdl-mixer1.2-dev" "libsdl-ttf2.0-dev" "libsmpeg-dev" "libsdl1.2-dev" "libportmidi-dev" "libswscale-dev" "libavformat-dev" "libavcodec-dev")

        for dep in "${packages[@]}"
        do
            inst_ver=$(apt-cache policy $dep |grep Installed: | sed 's/\s*Installed: \(.*\)$/\1/')
            echo "Dependency $dep (installed version: $inst_ver)"
            if [[ "$inst_ver" == "(none)" ]]; then
                echo "Please install dependency $dep!"
                exit 1;
            fi
        done
    fi
fi

$PYTHON setup.py install
