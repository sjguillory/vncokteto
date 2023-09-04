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
RUN echo 'cd /home/dvps' >>/luo.sh
RUN echo "su dvps -l -c 'USER=dvps HOME=/home/dvps vncserver :0'" >>/luo.sh
RUN echo 'cd /noVNC-1.4.0' >>/luo.sh
RUN echo 'bash ./utils/novnc_proxy --vnc localhost:5900 --listen 443' >>/luo.sh
RUN chmod 755 /luo.sh
EXPOSE 443
CMD  /luo.sh
