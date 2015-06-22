#!/bin/sh

echo "-GIT"

retr () {
    o=$(curl --silent -w "%{http_code}" -o $2 $1)
    if [[ $o == 2* ]];then
        echo "---[32msuccess[0m"
    elif [[ $o == 4* ]];then
        echo "---[32mfailure[0m"
        exit $o
    else
        echo "---[35munknown failure[0m"
        exit $o
    fi
}

inst () {
    retr "https://raw.githubusercontent.com/tsu-complete/dot/master/$1" $2
}

echo "--global ignore"
retr https://www.gitignore.io/api/linux,osx ~/.gitignore

echo "--global config"
inst git/_gitconfig ~/.gitconfig

read -p "---prompt: user.name  : " confuname
read -p "---prompt: user.email : " confemail
read -p "---prompt: editor     : " confeditor
read -p "---prompt: difftool   : " confdifftool

echo "
# user settings
[user]
    name = $confuname
    email = $confemail
[core]
    editor = $confeditor
[diff]
    tool = $confdifftool
" >> ~/.gitconfig

