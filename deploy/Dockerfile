############################################################

# Dockerfile to build docker container images

# Based on centos7.2

############################################################
#Version 1.0

#基础镜像
FROM czwei2/mykolla_base:latest

#维护人
MAINTAINER czwei2@iflytek.com

################### BEGIN INSTALLATION ######################

#替换密码
RUN kolla-genpwd &&\
sed -i 's/keystone_admin_password.*/keystone_admin_password: abc123456/g' /etc/kolla/passwords.yml

#拷贝配置文件
COPY ./../add/kolla-deploy.sh /
COPY ./../add/ssh.conf /
COPY ./../add/globals.yml /etc/kolla/
COPY ./../add/multinode /home/

#执行启动脚本
CMD sh /kolla-deploy.sh



