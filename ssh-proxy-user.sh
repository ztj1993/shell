#!/bin/bash

###############
# Name: add proxy user
# Author: Ztj
# Email: ztj1993@gmail.com
# LastDate: 2019-08-31
# Use:
#     wget https://raw.githubusercontent.com/ztj1993/shell/master/ssh-proxy-user.sh
#     chmod +x ssh-proxy-user.sh
#     sudo ./ssh-proxy-user.sh {username}
#     echo ${password} | passwd ${username} --stdin
###############

ssh_user=${ssh_user:-${1}}

[[ -z ${ssh_user} ]] && read -p ">>> Please enter the ssh user name: " read_ssh_user
[[ -z ${ssh_user} ]] && [[ -z ${read_ssh_user} ]] && echo ">>> Please enter the ssh user name." && exit 1

[[ ! -f /usr/bin/proxylogin ]] && echo '
#!/bin/sh
stty erase ^H
stty kill ^U
echo -en "SSH to Host :"
read host
echo -en "UserName: "
read username
/usr/bin/ssh $host -l $username
' | tee /usr/bin/proxylogin > /dev/null

[[ ! -f /usr/bin/proxylogin ]] && [[ $? -ne 0 ]] && echo "Error: proxy login file write failure." && exit 1

groupadd -f proxy

id -u ${ssh_user} > /dev/null 2>&1

if [[ $? -ne 0 ]]; then
    useradd -M -g proxy -s /usr/bin/proxylogin ${ssh_user}
    [[ $? -ne 0 ]] && echo "Error: ssh user add failure." && exit 1
    echo ">>> Success: add proxy user: ${ssh_user}"
else
    echo ">>> Error: the username exists"
    exit 1
fi
