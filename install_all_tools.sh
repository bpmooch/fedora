#!/bin/bash

set -ex

. ./lib/install.sh

echo 'Installing podman'
install_podman

echo 'Installing kubectl'
install_kubectl

echo 'Installing krew'
install_krew

echo 'Installing vscode'
install_vscode
