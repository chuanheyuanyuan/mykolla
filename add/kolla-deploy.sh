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
for p in $(cat /ssh.conf)
do  
ip=$(echo "$p"|cut -f1 -d":")       #取ssh.conf文件中的主机名  
password=$(echo "$p"|cut -f2 -d":") #取ssh.conf文件中的密码

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

kolla-ansible deploy -i /home/multinode --tag="nova"
		













