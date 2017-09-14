############################################################

# Dockerfile to build docker container images

# Based on centos7.2

############################################################
#Version 1.0

#基础镜像
<<<<<<< HEAD:Dockerfile
FROM czwei2/mykolla_base:1.0
=======
FROM czwei2/mykolla_base:latest
>>>>>>> 4601e35db0a2a72a857ea62ff3223701791cc60c:deploy/Dockerfile

#维护人
MAINTAINER czwei2@iflytek.com

################### BEGIN INSTALLATION ######################

#替换密码
RUN kolla-genpwd &&\
sed -i 's/keystone_admin_password.*/keystone_admin_password: abc123456/g' /etc/kolla/passwords.yml

<<<<<<< HEAD:Dockerfile
#拷贝配置文件(在执行build之前，要先改好配置文件）
COPY ./add/expect-ssh.sh /
COPY ./add/ip.txt /
COPY ./add/globals.yml /etc/kolla/
COPY ./add/multinode /home/
COPY ./add/ceph.conf /etc/kolla/config/
=======
#拷贝配置文件
COPY ./../add/kolla-deploy.sh /
COPY ./../add/ssh.conf /
COPY ./../add/globals.yml /etc/kolla/
COPY ./../add/multinode /home/
>>>>>>> 4601e35db0a2a72a857ea62ff3223701791cc60c:deploy/Dockerfile

#执行启动脚本
CMD sh /kolla-deploy.sh



