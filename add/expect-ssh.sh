#! /bin/bash

#创建密钥
expect -c "
spawn ssh-keygen 
expect { 
	\"file in which to save the key\" {
		send \"\n\r\"
		exp_continue
	}
	\"*Enter passphrase*\" {
		send \"\n\r\"
		exp_continue
	}
	\"*Enter same passphrase again*\" {
		send \"\n\r\"
		exp_continue
	}
}
"

#把密钥拷贝到远端机器，并访问
for p in $(cat /ip.txt)
do  
ip=$(echo "$p"|cut -f1 -d":")       #取ip.txt文件中的ip地址  
password=$(echo "$p"|cut -f2 -d":") #取ip.txt文件中的密码

expect -c "
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$ip
expect {
	\"*Are you sure you want to continue connecting*\" {
		send \"yes\r\"
		exp_continue
	}
	
	\"*password*\" {
		send \"$password\r\"
		exp_continue
	}
}
"

done

for p in $(cat /ip.txt)
do 
ip=$(echo "$p"|cut -f2 -d":")
scp docker-engine-1.12.5-1.el7.centos.x86_64.rpm docker-engine-selinux-1.12.5-1.el7.centos.noarch.rpm $ip:/
done

ansible-playbook -i /home/multinode start.yml

#kolla-ansible destroy  -i /home/multinode --yes-i-really-really-mean-it --tags="ceph"
kolla-ansible deploy -i /home/multinode --tags="ceph"
#kolla-ansible bootstrap-osd -i /home/multinode --tags="ceph"
#kolla-ansible  prechecks -i /home/multinode --tags="ceph"
#kolla-ansible reconfigure -i /home/multinode  --tags="ceph"
