FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install firefox-esr mate-system-monitor git lxde tightvncserver wget vim sudo -y
RUN useradd -m -p $(openssl passwd -1 zaq12wsx) -s /bin/bash -G sudo dvps
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz
RUN tar -xvf v1.4.0.tar.gz
RUN mkdir /root/.vnc
RUN mkdir /home/dvps/.vnc
RUN echo 'zaq12wsx' | vncpasswd -f > /root/.vnc/passwd
RUN echo 'zaq12wsx' | vncpasswd -f > /home/dvps/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd
RUN chmod 600 /home/dvps/.vnc/passwd
RUN cp /noVNC-1.4.0/vnc.html /noVNC-1.4.0/index.html
RUN echo 'VNCSERVERS="1:root 2:dvps"' >> /usr/bin/vncserver
RUN echo 'VNCSERVERSVNCSERVERARGS[1]="-geometry 1024x600 -alwaysshared"' >> /usr/bin/vncserver
RUN echo 'VNCSERVERSVNCSERVERARGS[2]="-geometry 1024x600 -alwaysshared"' >> /usr/bin/vncserver
RUN echo root:vncokteto1234|chpasswd
RUN cd /root
RUN su root -l -c 'vncserver :2000'
RUN cd /noVNC-1.4.0
RUN ./utils/novnc_proxy --vnc localhost:7900 --listen 80
EXPOSE 80
