#!/bin/sh

echo "-GIT"

retr () {
    curl -# $1 > $2
}

inst () {
    retr "https://raw.githubusercontent.com/tsu-complete/dot/master/$1" $2
}

echo "--global ignore"
retr https://www.gitignore.io/api/linux,osx ~/.gitignore

echo "--global config"
inst git/_gitconfig ~/.gitconfig

read -p "---prompt: user.name  : " uname
read -p "---prompt: user.email : " email

echo "" >> ~/.gitconfig
echo "[user]" >> ~/.gitconfig
echo "    name = $uname" >> ~/.gitconfig
echo "    email = $email" >> ~/.gitconfig

