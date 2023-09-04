FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install firefox-esr mate-system-monitor git lxde tightvncserver wget vim sudo -y
RUN useradd -m -p $(openssl passwd -1 zaq12wsx) -s /bin/bash -G sudo dvps
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz
RUN tar -xvf v1.4.0.tar.gz
