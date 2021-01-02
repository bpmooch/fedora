#!/bin/bash

set -e

. ./lib/install.sh
. ./lib/util.sh

# don't put stuff here that doesn't install cleanly
# don't put stuff here that isn't idempotent
info 'Vim' 'Installing vim-X11'
install_vim

info 'Podman' 'Installing podman'
install_podman

info 'Rust' 'Installing Rust + tools'
install_rust

info 'kubectl' 'Installing kubectl'
install_kubectl

info 'Discord' 'Installing Discord'
install_discord

info 'AWS IAM Authenticator' 'Installing aws-iam-authenticator'
install_aws_iam_authenticator

info 'Pritunl' 'Installing pritunl vpn client'
install_pritunl

info 'Visual Studio Code' 'Installing vscode + extensions'
install_vscode

info 'Vault' 'Installing vault'
install_vault
