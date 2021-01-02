#!/bin/bash

set -e

. ./lib/install.sh
. ./lib/util.sh

warning "If the following doesn't work and you have krew installed, you likely haven't added it to your path"
install_krew_plugins
