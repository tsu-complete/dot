#!/bin/sh

echo "-GIT"

retr () {
    o=$(curl --silent -w "%{http_code}" -o $2 $1)
    if [[ $o == 2* ]];then
        echo "-- [32m[success][0m"
    elif [[ $o == 4* ]];then
        echo "-- [32m[failure][0m"
        exit $o
    else
        echo "-- [35m[unknown failure][0m"
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

read -p "---prompt: user.name  : " uname
read -p "---prompt: user.email : " email

echo "" >> ~/.gitconfig
echo "[user]" >> ~/.gitconfig
echo "    name = $uname" >> ~/.gitconfig
echo "    email = $email" >> ~/.gitconfig

