# Fedora 33 Stuff
random scripts and things

## Scripts
* [Create ssh rsa keys and copy them to the clipboard](create-ssh-key)
## Style
https://google.github.io/styleguide/shellguide.html

## Resources
*	[$* and $@](https://eklitzke.org/bash-$*-and-$@)

## Installing Volta
Volta's installer doesn't work on fedora. I ended up having to build from source using [this guide](https://docs.volta.sh/contributing/). I also enjoyed reading through [this folder](https://github.com/volta-cli/volta/tree/main/dev/unix)

## [Terminator](https://terminator-gtk3.readthedocs.io/en/latest/) Ctrl+Shift+e isn't splitting vertically
`ibus-emoji` is installed by default. You can edit or disable the `ibus-emoji` shortcut using `ibus-setup`, a gtk3 application for editing IBUS options. More on IBUS [here](https://fedoraproject.org/wiki/I18N/IBus)
