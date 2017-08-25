############################################################

# Dockerfile to build docker container images

# Based on centos7.2

############################################################
#Version 1.0

#基础镜像
FROM mykolla_base:latest

#维护人
MAINTAINER czwei2@iflytek.com

################### BEGIN INSTALLATION ######################

#替换密码
RUN kolla-genpwd &&\
sed -i 's/keystone_admin_password.*/keystone_admin_password: abc123456/g' /etc/kolla/passwords.yml

#拷贝配置文件(在执行build之前，要先改好配置文件）
COPY ./add/expect-ssh.sh /
COPY ./add/ip.txt /
COPY ./add/globals.yml /etc/kolla/
COPY ./add/multinode /home/

#创建信任关系
CMD sh /expect-ssh.sh



