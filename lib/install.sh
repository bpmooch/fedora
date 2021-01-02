#!/bin/bash

# install gvim for clipboard support
install_vim() {
	# after installation, create alias vim="gvim -v" to
	# utilize vim in the terminal with +clipboard
	# if it still doesn't work, look at selinux
	sudo dnf -y install vim-X11
}

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
	if ! [ -e "/etc/yum.repos.d/vscode.repo" ];
	then
		sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
		sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
		sudo dnf check-update || true # ignore 100 return code
	fi
	sudo dnf -y install code

	## install extensions
	info "Visual Studio Code" "Installing vim mode, eslint, prettier, and the dracula theme"
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

# install krew plugins
install_krew_plugins() {
	kubectl krew install ctx
	kubectl krew install ns
	kubectl krew install tail
}

# install pritunl client
install_pritunl() {
	if ! [ -e "/etc/yum.repos.d/pritunl.repo" ];
	then
		sudo tee /etc/yum.repos.d/pritunl.repo << EOF
[pritunl]
name=Pritunl Stable Repository
baseurl=https://repo.pritunl.com/stable/yum/fedora/33/
gpgcheck=1
enabled=1
EOF

		gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
		gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp
		sudo rpm --import key.tmp
		rm -f key.tmp
	fi

	sudo dnf -y install pritunl-client-electron
}

# install aws cli
install_aws_cli() {
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
}

# install aws iam authenticator
install_aws_iam_authenticator() {
	if ! [ -e "/usr/local/bin/aws-iam-authenticator" ];
	then
		BIN_NAME='aws-iam-authenticator'
		curl -o $BIN_NAME https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator
		chmod +x "./$BIN_NAME"
		sudo mv "./$BIN_NAME" /usr/local/bin/
		echo "installed aws-iam-authenticator at /usr/local/bin/aws-iam-authenticator"
	else
		echo "aws-iam-authenticator already exists in /usr/local/bin"
	fi
}

# vault installer
install_vault() {
	sudo dnf install -y dnf-plugins-core
	sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
	sudo dnf -y install vault
}
