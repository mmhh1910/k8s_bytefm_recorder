FROM linuxserver/ffmpeg

RUN apt-get update -y && apt-get install -y unzip fuse3 tzdata

RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR /app

COPY ./install_rclone.sh .
RUN bash ./install_rclone.sh

COPY assets/root/ /

COPY ./record_bytefm.sh .

ENTRYPOINT ["/bin/bash"]
CMD ["record_bytefm.sh", "00:59:55"]
