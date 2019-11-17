#!/usr/bin/env bash

checkKeycodeForEnter() {
    local _KEYCODE=$(printf %s $1 | xxd)
    local enter="0d00 0000"
    if $(echo $_KEYCODE | grep -iq $ENTER); then
        return 0
    fi

    _localInterceptKeycode
}

_localInterceptKeycode() {
    local _KEYCODE
    {   _STTY_STATE=$(stty -g)
        stty raw isig -echo
        _KEYCODE=$(dd bs=8 conv=sync count=1)
        stty $_STTY_STATE
    } </dev/tty 2>/dev/null
    checkKeycodeForEnter $_KEYCODE
}

_localInterceptKeycode