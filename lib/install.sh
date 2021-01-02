#!/bin/bash

# install podman, daemonless docker alternative
install_podman() {
	sudo dnf -y install podman
}

# install rust, cargo, and clippy
install_rust() {
	sudo dnf -y install rust cargo clippy
}

# install discord using flatpak
install_discord() {
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install flathub com.discordapp.Discord
}

# install vscode + extensions
install_vscode() {
	# install vscode + extensions
	info "Visual Studio Code" "Installing VS Code"
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	sudo dnf check-update || true # ignore 100 return code
	sudo dnf -y install code

	## install extensions
	info "Extensions" "Installing vim mode, eslint, prettier, and the dracula theme"
	code --install-extension vscodevim.vim
	code --install-extension dbaeumer.vscode-eslint
	code --install-extension esbenp.prettier-vscode
	code --install-extension dracula-theme.theme-dracula
}

# install kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-using-native-package-management
install_kubectl() {
	if ! [ -e "/etc/yum.repos.d/kubernetes.repo" ]; then
		cat <<EOF > kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
		sudo cp ./kubernetes.repo /etc/yum.repos.d/
		rm ./kubernetes.repo
	fi

	sudo yum install -y kubectl
}

# install krew - kubectl plugin manager
# After installation, ensure to add it to PATH
# Installation will output instructions
install_krew() {
	(
	  set -x; cd "$(mktemp -d)" &&
	  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
	  tar -zxvf krew.tar.gz &&
	  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/')" &&
	  "$KREW" install krew
	)
}

#install krew plugins
install_krew_plugins() {
	kubectl krew install ctx
	kubectl krew install ns
	kubectl krew install tail
}
