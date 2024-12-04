#!/bin/bash

envs=$@

install_packages() {
    apt-get update
    apt-get install -y git tmux neovim zsh pipx
}

install_miniforge() {
    wget -O Miniforge3.sh  "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
    bash Miniforge3.sh -b
    rm Miniforge3.sh
    ~/miniforge3/bin/mamba init

    source "${HOME}/conda/etc/profile.d/conda.sh"
    # For mamba support also run the following command
    source "${HOME}/conda/etc/profile.d/mamba.sh"
}

install_dl_envs() {
    for env in $envs; do
        if [ env == "torch"]; then mamba create env -f torch/torch.yaml; fi
        if [ env == "jax" ]; then mamba create env -f jax/jax.yaml; fi
    done
}