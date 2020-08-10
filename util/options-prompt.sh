#!/bin/bash

# Call prompt by running the file.
# arg1 - the fitle in the prompt
# arg2-N - the options or as an array
# The functions sets the result to the global variable $_RESULT as an array

# Escape codes
ARROWUP="1b5b 4100"
ARROWDOWN="1b5b 4200"
SPACE="2000 0000"
ENTER="0d00 0000"
q="7100 0000"
Q="5100 0000"

# Box drawing characters
BAR="\x1b(0\x78\x1b(B"
DASH="\x1b(0\x71\x1b(B"
UPPERLEFT="\x1b(0\x6c\x1b(B"
UPPERRIGHT="\x1b(0\x6b\x1b(B"
LOWERRIGHT="\x1b(0\x6a\x1b(B"
LOWERLEFT="\x1b(0\x6d\x1b(B"
DASHRIGHT="\x1b(0\x75\x1b(B"
DASHLEFT="\x1b(0\x74\x1b(B"

# Get title and options from arguments
# arg1 - title
TITLE=$1
shift
# arg2-N - options
OPTIONS=("$@")

# Get length of options
OPTIONS_LEN=${#OPTIONS[@]}

# Set initial options selection
declare -a SEL_OPTIONS=( $(for i in {1..$OPTIONS_LEN}; do echo 1; done) )

# Initial marker position
CURSOR_POS=1

# Width of prompt in characters
WIDTH=60

# Check if string includes another string
# arg1 - string to search in
# arg2 - string to search for
includes() {
    return $(echo $1 | grep -iq $2)
}

# Print title and surrounding borders
printTitle() {
    local _TITLE=$TITLE
    local _TITLE_LEN="${#_TITLE}"

    echo -n " ${D}${UPPERLEFT}"
    local i=0; while (( i < ( WIDTH - 3 ) )); do echo -n "${DASH}"; ((i++)); done
    echo -e "${UPPERRIGHT}${R}\r"

    echo -n " ${D}${BAR}${R} ${B}${_TITLE}${R}"
    local i=0; while (( i < ( WIDTH - _TITLE_LEN - 4 ) )); do echo -n " "; ((i++)); done
    echo -e "${D}${BAR}${R}\r"

    echo -n " ${D}${DASHLEFT}"
    local i=0; while (( i < ( WIDTH - 3 ) )); do echo -n "${DASH}"; ((i++)); done
    echo -e "${DASHRIGHT}${R}\r"
}

# Print instructions and side borders
printInstructions() {
    echo -n " ${BAR} ${I}[SPACE] = select, [ENTER] = proceed, [Q] = quit${R}${D}"
    local i=0; while (( i < ( WIDTH - 45 ) )); do echo -n " "; ((i++)); done
    echo -e "${BAR}\r"
}

# Print empty row with side borders
printEmptyRow() {
    echo -n " ${D}${BAR}"
    local i=0; while (( i < ( WIDTH - 3 ) )); do echo -n " "; ((i++)); done
    echo -e "${BAR}\r"
}

# Print end of prompt with bottom border
printEnd() {
    echo -n " ${LOWERLEFT}"
    local i=0; while (( i < ( WIDTH - 3 ) )); do echo -n "${DASH}"; ((i++)); done
    echo -e "${LOWERRIGHT}${R}\r"
}

# Print list of options with selection checkboxes and position cursor
printOptions() {
    local _COUNT=1
    while (( _COUNT <= OPTIONS_LEN )); do
        local _LEN="${#OPTIONS[$_COUNT]}"
        echo -n " ${D}${BAR}${R} "
        (( CURSOR_POS == _COUNT )) && echo -n "${YELLOW} ➤${R} " || echo -n "   "
        (( SEL_OPTIONS[_COUNT] == 1 )) && echo -n "[${GREEN}✔︎${R}] " || echo -n "[ ] "
        echo -n "${OPTIONS[$_COUNT]}"
        local i=0; while (( i < ( WIDTH - _LEN - 11 ) )); do echo -n " "; ((i++)); done
        echo -e "${D}${BAR}${R}\r"
        (( _COUNT++ ))
    done
}

clearPrompt() {
    tput civis
    local _LEN=$(( OPTIONS_LEN + 6 ))
    local _COUNT=1
    while (( _COUNT <= _LEN )); do
        tput cuu1
        tput el
        (( _COUNT++ ))
    done
    tput cnorm
}

# Clear previous print and render a new prompt
renderPrompt() {
    printTitle
    printOptions
    printEmptyRow
    printInstructions
    printEnd
}

# Move cursor up in list
moveCursorUp() {
    (( CURSOR_POS > 1 )) && (( CURSOR_POS-- ))
    clearPrompt
    renderPrompt
}

# Move cursor down in list
moveCursorDown() {
    (( CURSOR_POS < OPTIONS_LEN )) && (( CURSOR_POS++ ))
    clearPrompt
    renderPrompt
}

# Toggle option selection
toggleOption() {
    (( SEL_OPTIONS[CURSOR_POS] == 0 )) && SEL_OPTIONS[CURSOR_POS]=1 || SEL_OPTIONS[CURSOR_POS]=0
    clearPrompt
    renderPrompt
}

# Set result, cleanupOptionsPrompt and exit script
setResult() {
    _RESULT=("${SEL_OPTIONS[@]}")
}

# Check which has been pressed
checkKeycode() {
    local _KEYCODE=$(printf %s $1 | xxd)

    if includes $_KEYCODE $ARROWUP; then
        moveCursorUp
        interceptKeycode
        return 0
    fi

    if includes $_KEYCODE $ARROWDOWN; then
        moveCursorDown
        interceptKeycode
        return 0
    fi

    if includes $_KEYCODE $SPACE; then
        toggleOption
        interceptKeycode
        return 0
    fi

    if includes $_KEYCODE $ENTER; then
        setResult
        return 0
    fi
    
    if includes $_KEYCODE $Q; then
        exit 1
        return 1
    fi

    if includes $_KEYCODE $q; then
        exit 1
        return 1
    fi

    interceptKeycode
}

# Intercept keycode from keypress and pass it to keycode checker
interceptKeycode() {
    local _KEYCODE
    {   _STTY_STATE=$(stty -g)
        stty raw isig -echo
        _KEYCODE=$(dd bs=8 conv=sync count=1)
        stty $_STTY_STATE
    } </dev/tty 2>/dev/null
    checkKeycode $_KEYCODE
}

# Run script
renderPrompt
interceptKeycode
