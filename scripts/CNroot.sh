#!/bin/bash
/bin/cp -f ~ec2-user/.ssh/authorized_keys ~root/.ssh/authorized_keys

sed -i "s/^disable_root: 1/disable_root: 0/g" /etc/cloud/cloud.cfg

sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart sshd

usermod root -p `openssl passwd -6 -stdin <<< "redhat"`

hostnamectl set-hostname  ${hostname}

echo '${node1}	node1.${domain}.example.com node1' >> /etc/hosts
echo '${node2}	node2.${domain}.example.com node2' >> /etc/hosts
echo '${node3}	node3.${domain}.example.com node3' >> /etc/hosts
echo '${node4}	node4.${domain}.example.com node4' >> /etc/hosts
echo '${node5}	node5.${domain}.example.com node5' >> /etc/hosts

useradd -G wheel ${remote_user} -p `openssl passwd -6 -stdin <<< "redhat"`
echo '${remote_user}    ALL=(ALL)       NOPASSWD: ALL' > /etc/sudoers.d/${remote_user}
chmod 0400 /etc/sudoers.d/${remote_user}

sudo runuser -l ${remote_user} -c "mkdir -p ~${remote_user}/.ssh && chmod 700 ~${remote_user}/.ssh"
sudo runuser -l ${remote_user} -c "touch ~${remote_user}/.ssh/authorized_keys && chmod 600 ~${remote_user}/.ssh/authorized_keys"

/bin/cp -f ~ec2-user/.ssh/authorized_keys ~${remote_user}/.ssh/authorized_keys

ssh-keygen -t rsa -b 4096 -P "" -f ~root/.ssh/id_rsa
ssh-keygen -t rsa -b 4096 -P "" -f ~${remote_user}/.ssh/id_rsa

chown ${remote_user} ~${remote_user}/.ssh/*
chgrp ${remote_user} ~${remote_user}/.ssh/*

sed -i "s/root@control/${remote_user}@control/g" ~${remote_user}/.ssh/id_rsa.pub

yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y 
yum install sshpass -y

sudo runuser -l root -c 'for s in node{1..5}; do sshpass -p "redhat" ssh-copy-id -o StrictHostKeyChecking=no root@"$s"; done'

sudo runuser -l ${remote_user} -c 'for s in node{1..5}; do sshpass -p "redhat" ssh-copy-id -o StrictHostKeyChecking=no ${remote_user}@"$s"; done'

for s in node{1..5}
do 
	ssh root@"$s" -- 'sed -i "s/^PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config'
	ssh root@"$s" -- 'systemctl restart sshd'
done

yum remove sshpass -y && yum clean all

echo 'PS1="\[\e[1;32m\][\u@\h \W]\\$ \[\e[m\]"' > /etc/profile.d/hello.sh