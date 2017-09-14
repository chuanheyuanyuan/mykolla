
echo "Edit hosts file" 
echo "172.21.195.11	      test01openstack" >> /etc/hosts && echo "01done"
echo "172.21.195.12       test02openstack" >> /etc/hosts && echo "02done"
echo "172.21.195.13       test03openstack" >> /etc/hosts && echo "03done"
echo "172.21.195.14       test04openstack" >> /etc/hosts && echo "04done"
echo "172.21.195.15       test05openstack" >> /etc/hosts && echo "05done"
echo "172.21.195.16       test06openstack" >> /etc/hosts && echo "06done"

echo "yum install epel-release"
yum install -y epel-release && echo "done"

echo "yum install python-pip"
yum install -y python-pip 

echo "make docker.repo"
tee /etc/yum.repos.d/docker.repo << 'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

echo "yum install docker "
yum install -y docker-engine-1.12.5 docker-engine-selinux-1.12.5

echo "pip install docker-py1.8.1"
pip install docker-py==1.8.1

echo "mkdir docker.service.d"
mkdir /etc/systemd/system/docker.service.d

echo "edit mountflags=shared"
tee /etc/systemd/system/docker.service.d/kolla.conf << 'EOF'
[Service]
MountFlags=shared
EOF

echo "edit file /usr/lib/systemd/system/docker.service"
sed -i 's%ExecStart=/usr/bin/dockerd.*%ExecStart=/usr/bin/dockerd --insecure-registry 172.21.195.97:4000%g' /usr/lib/systemd/system/docker.service

echo "restart docker"
systemctl daemon-reload
systemctl restart docker







