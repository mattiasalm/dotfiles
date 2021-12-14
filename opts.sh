#!/bin/zsh -e

# Include tools as binary functions
PATH=$PATH:$DOTFILES_PATH/tools

# Trap ctrl+c (abort script)
# To make sure that stty is restored
_STTY_STATE=$(stty -g)
reset_stty() {
	stty $_STTY_STATE &>/dev/null
}

TRAPINT() {
	reset_stty
	return 1
}

# Input arguments
_OPTIONS=("$@")
_OPTIONS_LENGTH=$(expr ${#_OPTIONS[@]} - 1)
_CURSOR=0

# Check if any options has been provided
if [ "$_OPTIONS_LENGTH" -lt 0 ]; then
	color-print red "No options provided"
	exit 1
fi

clear_options() {
	tput civis
	for _ in ${_OPTIONS[@]}; do
		tput cuu1
		tput el
	done
	tput cnorm
}

print_options() {
	local _COUNTER=0
	for _OPTION in ${_OPTIONS[@]}; do
		if (( _COUNTER == _CURSOR )); then
			echo " \e[1m\e[32m→\e[0m  \e[1m$_OPTION\e[0m"
		else
			echo "    $_OPTION"
		fi
		((_COUNTER++))
	done
}

key_press_down() {
	(( _CURSOR < _OPTIONS_LENGTH )) && (( _CURSOR++ ))
	clear_options
	print_options
}

key_press_up() {
	(( _CURSOR > 0 )) && (( _CURSOR-- ))
	clear_options
	print_options
}

key_press_enter() {
	SELECTED_OPTION=$_CURSOR
	reset_stty
	exit 0
}

check_key_code() {
	if [[ $1 =~ "1b5b 4100" ]]; then
		key_press_up
	elif [[ $1 =~ "1b5b 4200" ]]; then
		key_press_down
	elif [[ $1 =~ "0d00 0000" ]]; then
		key_press_enter
	elif [[ $1 =~ "1b00 0000" ]]; then
		reset_stty
		exit 1
	elif [[ $1 =~ "5100 0000" ]]; then
		reset_stty
		exit 1
	elif [[ $1 =~ "7100 0000" ]]; then
		reset_stty
		exit 1
	fi

	catch_key_press
}

# Catch key press action and convert to 
catch_key_press() {
	local _KEYCODE
	{
		stty raw isig -echo
		local _KEY=$(dd bs=8 conv=sync count=1)
		_KEYCODE=$(printf %s $_KEY | xxd)
		reset_stty
	} </dev/tty 2>/dev/null
	check_key_code $_KEYCODE
}

print_options
catch_key_press