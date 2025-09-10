PATH=$PATH:$DOTFILES_PATH/tools

if is-available n; then
	npm config set save-exact=true
else
	color-print red "npm is missing, needed to set NPM config."
fi