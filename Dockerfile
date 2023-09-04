FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install firefox-esr mate-system-monitor git lxde tightvncserver wget vim sudo -y
RUN useradd -m -p $(openssl passwd -1 zaq12wsx) -s /bin/bash -G sudo dvps
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz
RUN tar -xzvf v1.4.0.tar.gz
RUN mkdir /root/.vnc
RUN echo 'zaq12wsx' | vncpasswd -f > /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd
RUN cp /noVNC-1.4.0/vnc.html /noVNC-1.4.0/index.html
RUN sed -i 's/1024x768/1024x600/g' /usr/bin/vncserver
RUN echo root:vncokteto1234|chpasswd
RUN mkdir /home/dvps/.vnc
RUN echo 'zaq12wsx' | vncpasswd -f > /home/dvps/.vnc/passwd
RUN chmod 600 /home/dvps/.vnc/passwd
RUN chown -R dvps:dvps /home/dvps/.vnc
RUN su - dvps
RUN USER=dvps vncserver :2000
RUN cd /noVNC-1.4.0
RUN bash ./utils/novnc_proxy --vnc localhost:7900 --listen 443
EXPOSE 443
