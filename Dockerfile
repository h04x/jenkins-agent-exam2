FROM centos:8

RUN yum install --setopt=skip_missing_names_on_install=False -y \
    java-1.8.0-openjdk openssh-server \
    python3 python3-pip git python3-coverage yum-utils 

RUN yum install -y epel-release && yum install -y ansible

RUN yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
RUN yum-config-manager --enable docker-ce-nightly
RUN yum install -y docker-ce

RUN sed -i /etc/ssh/sshd_config \
    -e 's/#RSAAuthentication.*/RSAAuthentication yes/'  \
    -e 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/'

RUN useradd -m -s /bin/bash jenkins && mkdir /home/jenkins/.ssh \
    mkdir /root/.ssh
ADD id_rsa.pub /home/jenkins/.ssh/authorized_keys

RUN ssh-keygen -A
RUN mkdir /run/sshd

RUN rm /run/nologin

EXPOSE 22

ADD entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]