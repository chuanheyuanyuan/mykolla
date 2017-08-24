############################################################

# Dockerfile to build docker container images

# Based on centos7.2

############################################################
#Version 1.0

#基础镜像
FROM centos:7.2.1511

#维护人
MAINTAINER czwei2@iflytek.com

################### BEGIN INSTALLATION ######################



#安装各种插件
RUN yum install -y epel-release
RUN yum install -y python-devel libffi-devel gcc openssl-devel git python-pip ntp

#安装ansible
RUN (yum install -y ansible || yum install -y ansible)

#升级pip
RUN pip install --upgrade pip

#安装kolla-ansible
RUN cd /home &&\
git clone http://git.trystack.cn/openstack/kolla-ansible -b stable/ocata && \
cd kolla-ansible && \
pip install . && \
cp -r etc/kolla /etc/kolla/ && \
cp ansible/inventory/* /home/ 

#替换密码
RUN kolla-genpwd &&\
sed -i 's/keystone_admin_password.*/keystone_admin_password: thinkbig1/g' /etc/kolla/passwords.yml
