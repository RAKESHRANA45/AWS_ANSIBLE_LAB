#!/bin/bash
/bin/cp -f ~ec2-user/.ssh/authorized_keys ~root/.ssh/authorized_keys

sed -i "s/^disable_root: 1/disable_root: 0/g" /etc/cloud/cloud.cfg

sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart sshd

usermod root -p `openssl passwd -6 -stdin <<< "redhat"`

hostnamectl set-hostname  ${hostname}

useradd -G wheel ${remote_user} -p `openssl passwd -6 -stdin <<< "redhat"`
echo '${remote_user}    ALL=(ALL)       NOPASSWD: ALL' > /etc/sudoers.d/${remote_user}
chmod 0400 /etc/sudoers.d/${remote_user}
runuser -l ${remote_user} -c "mkdir -p ~${remote_user}/.ssh && chmod 700 ~${remote_user}/.ssh"
runuser -l ${remote_user} -c "touch ~${remote_user}/.ssh/authorized_keys && chmod 600 ~${remote_user}/.ssh/authorized_keys"
/bin/cp -f ~ec2-user/.ssh/authorized_keys ~${remote_user}/.ssh/authorized_keys
echo 'PS1="\[\e[1;36m\][\u@\h \W]\\$ \[\e[m\]"' > /etc/profile.d/hello.sh
