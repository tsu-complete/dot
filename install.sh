#!/bin/sh

# scope helper functions {{{
  _scope_level=""
  scope () {
    _scope_level="$_scope_level-"
    if [ -n "$1" ]; then
      echo $_scope_level$@
    fi
  }

  sprint () {
    printf "%s$1" "-$_scope_level" ${@:2}
  }
  sprompt () {
    read -p "${_scope_level}prompt: $1" $2
  }

  sprint_success () {
    sprint "%s" "[32msuccess[0m"
    echo " $1"
  }
  sprint_failure () {
    sprint "%s" "[31mfailure[0m"
    echo " $1"
    exit 1
  }
  sprint_unknown_failure () {
    sprint "%s" "[35munknown failure[0m"
    echo " $1"
    exit 3
  }

  sprint_perror () {
    if [[ $? == 0 ]]; then
      sprint_success $1
    else
      sprint_failure $?
    fi
  }

  endscope () {
    _scope_level=${_scope_level#-}
  }
# }}}

# curl helper functions {{{
  retr () {
    o=$(curl --silent -w "%{http_code}" -o "/tmp/dot/$2" $1)
    if [[ $o == 2* ]];then
      sprint_success $2
    elif [[ $o == 4* ]];then
      sprint_failure $o
    else
      sprint_unknown_failure $o
    fi
  }

  inst () {
    install -b -m 0644 /tmp/dot/$1 $2 &>/dev/null
    sprint_perror $2
  }

  instdir () {
    install -d "$2" &>/dev/null
    if [[ $? != 0 ]]; then
      sprint_failure $2
    fi
    inst "$1/*" "$2"
  }
# }}}

# preinstall {{{
  scope SETUP
    git clone -q https://github.com/tsu-complete/dot.git /tmp/dot
    sprint_perror
  endscope
# }}}

# install {{{
  # git {{{
    scope GIT
      scope global ignore
        retr https://www.gitignore.io/api/linux,osx git/_gitignore
        inst git/_gitignore ~/.gitignore
      endscope

      scope global config
        inst git/_gitconfig ~/.gitconfig

        if [ ! -f ~/.gitudata ]; then
          sprompt "user.name   : " confuname
          sprompt "user.email  : " confemail
          sprompt "core.editor : " confeditor
          sprompt "diff.tool   : " confdifftool

echo "
# user settings
[user]
    name = $confuname
    email = $confemail
[core]
    editor = $confeditor
[diff]
    tool = $confdifftool
" > ~/.gitudata

        fi

        cat ~/.gitudata >> ~/.gitconfig
      endscope
    endscope
  # }}}

  # vim {{{
    scope VIM
      scope vimrc
        inst vim/_vimrc ~/.vimrc
      endscope
      scope support
        instdir vim/_vim ~/.vim
        rm -rf ~/.vim/bundle # reset for vundle
        vim
      endscope
    endscope
  # }}}
# }}}

# postinstall {{{
  scope CLEANUP
    rm -rf /tmp/dot
    sprint_perror
  endscope
# }}}

