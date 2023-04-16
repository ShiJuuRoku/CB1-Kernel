FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

RUN apt-get update -y; \
    apt-get upgrade -y;

RUN apt install -y \
    sudo systemd ntpdate python3-pip git locales tzdata apt-utils

RUN apt-get install -y \
    ccache debian-archive-keyring debootstrap device-tree-compiler dwarves gcc-arm-linux-gnueabihf jq libbison-dev libc6-dev-armhf-cross libelf-dev libfl-dev liblz4-tool libpython2.7-dev libusb-1.0-0-dev pigz pixz pv swig pkg-config python3-distutils qemu-user-static u-boot-tools distcc uuid-dev lib32ncurses-dev lib32stdc++6 aptly aria2 libfdt-dev libssl-dev

RUN apt-get install -y \
    whiptail dialog psmisc acl uuid uuid-runtime curl gawk

RUN apt-get -y install apt-cacher-ng
# RUN sudo apt install auto-apt-proxy -y

RUN echo 'Acquire::HTTP::Proxy "http://localhost:3142";' >> /etc/apt/apt.conf.d/01proxy \
    && echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get clean all; \
    rm -rf /var/lib/apt/lists/*;

RUN sudo service apt-cacher-ng start
RUN apt-get update -y

RUN git clone --depth=1 https://github.com/ShiJuuRoku/CB1-Kernel.git
