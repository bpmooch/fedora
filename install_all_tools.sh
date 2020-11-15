#!/bin/bash

set -ex

. ./lib/install.sh

install_podman
install_kubectl
install_krew
