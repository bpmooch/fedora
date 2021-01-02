#!/bin/bash

set -e

. ./lib/install.sh
. ./lib/util.sh

# don't put stuff here that doesn't install cleanly
# don't put stuff here that isn't idempotent
info 'Podman' 'Installing podman'
install_podman

info 'Rust' 'Installing Rust + tools'
install_rust

info 'kubectl' 'Installing kubectl'
install_kubectl

info 'Discord' 'Installing Discord'
install_discord
