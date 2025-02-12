FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# installing ubuntu main packages
RUN apt update && \
apt install -y \
build-essential \
net-tools \
gcc \
make \
curl \
wget \
git \
vim \
nano \
sudo \
unzip \
zip \
tar \
software-properties-common \
apt-transport-https \
ca-certificates \
gnupg-agent

# creating user
ARG USER_NAME
ARG PASSWORD
RUN useradd -ms /bin/bash -G sudo ${USER_NAME}
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 
COPY . /home/${USER_NAME}/project
RUN chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/project
USER ${USER_NAME}

# install tests dependencies
WORKDIR /home/${USER_NAME}/project
RUN ./setup.sh
WORKDIR /home/${USER_NAME}/

CMD ["bash"]