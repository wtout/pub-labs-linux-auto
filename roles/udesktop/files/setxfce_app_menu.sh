#! /bin/bash

cp -r /etc/skel/.config ${HOME}
if [[ $(id | grep 'domain users' &>/dev/null; echo ${?}) -eq 0 ]] && [[ $(id | grep 'domain admins' &>/dev/null; echo ${?}) -ne 0 ]]
then
        continue
else
        rm -rf ${HOME}/.config/menus
fi
