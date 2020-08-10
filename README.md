## Installation scripts

### Alternative 1

Install with `zsh install.sh` after cloning the repository.

### Alternative 2

Install by running `i=~/Downloads/dotfiles && rm -rf $i && mkdir $i && curl -kLs https://github.com/mattiasalm/dotfiles/archive/master.tar.gz | gunzip | tar xopf - -C $i --strip-components=1 && cd $i && zsh install.sh`.