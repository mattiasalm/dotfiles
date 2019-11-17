#!/usr/bin/env bash

# General printing functions

print() {
    echo -e "${1}${R}\r"
}

printHeading() {
    print "\n  ${B}${U}${1}"
}

printTask() {
    if [[ "${2}" == 0 ]]; then
        print "  ${GREEN}✔︎${R} ${1}"
    elif [[ "${2}" == 0 ]]; then
        print "  ${RED}✘${R} ${1}"
    else
        print "  ${GREEN}●${R} ${1}"
    fi
}

printMessage() {
    print "  ${BLUE}${B}★${R} ${1}"
}

printInstalling() {
    print "  ${YELLOW}◼︎${R} ${1}"
}

printError() {
    print "  ${RED}${B}!${R} ${1}"
}

printNoteSuccess() {
    print "    ${I}${D}${1}"
}

printNoteError() {
    print "    ${I}${RED}${D}${1}"
}
