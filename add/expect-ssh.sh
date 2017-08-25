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
	\"*password*\" {
		send \"$password\r\"
		exp_continue
	}
}
"
expect -c "
spawn ssh root@$ip
expect {
	send /"exit\r/"
}
"
done


		













