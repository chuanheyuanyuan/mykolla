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
RUN yum install -y python-devel libffi-devel gcc openssl-devel git python-pip ntp expect

#安装ansible
RUN (yum install -y ansible || yum install -y ansible)

#升级pip
RUN pip install --upgrade pip

#安装kolla-ansible
RUN cd /home &&\
git clone http://git.trystack.cn/openstack/kolla-ansible -b stable/ocata && \
cd kolla-ansible && \
pip install . && \


#替换密码
RUN kolla-genpwd &&\
sed -i 's/keystone_admin_password.*/keystone_admin_password: abc123456/g' /etc/kolla/passwords.yml

#拷贝配置文件(在执行build之前，要先改好配置文件）
COPY ./add/expect-ssh.sh /
COPY ./add/ip.txt /
COPY ./add/globals.yml /etc/kolla/
COPY ./add/multinode /home/

#创建信任关系
RUN sh /expect-ssh.sh

#执行部署命令(每次组件升级需要修改tag）
RUN kolla-ansible deploy -i /home/multinode --tag="common"


