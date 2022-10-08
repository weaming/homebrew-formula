#!/bin/bash
# 读取文件中的密码来登录 ssh
# macOS: brew tap weaming/formula https://github.com/weaming/homebrew-formula.git && brew install weaming/formula/sshpass

user_host=$1
echo $user_host
passwd=$(cat ~/.ssh/passwords | grep "$user_host" | awk '{print $2}')
if [ -z "$passwd" ]; then
    echo missing password in file ~/.ssh/passwords:
    cat ~/.ssh/passwords
    exit 1
fi

shift
sshpass -p $passwd ssh -oStrictHostKeyChecking=no $user_host $@
